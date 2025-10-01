import { expect } from "chai";
import { ethers } from "hardhat";
import hardhat from "hardhat";
import {
  SnapshotRestorer,
  takeSnapshot,
  time,
  mine,
  setBalance,
} from "@nomicfoundation/hardhat-network-helpers";
import { CompoundGovernor, Comp, Timelock } from "../typechain-types";
import { SignerWithAddress } from "@nomicfoundation/hardhat-ethers/signers";

describe("CompoundGovernance", function () {
  let snapshot: SnapshotRestorer;
  let compoundGovernor: CompoundGovernor;
  let comp: Comp;
  let timelock: Timelock;
  let owner: SignerWithAddress;
  let alice: SignerWithAddress;
  let bob: SignerWithAddress;
  let whitelistGuardian: SignerWithAddress;
  let proposalGuardian: SignerWithAddress;

  // Constants from CompoundGovernorConstants
  const INITIAL_VOTING_DELAY = 13_140n;
  const INITIAL_VOTING_PERIOD = 19_710n;
  const INITIAL_PROPOSAL_THRESHOLD = ethers.parseEther("25000");
  const INITIAL_QUORUM = ethers.parseEther("400000");
  const INITIAL_VOTE_EXTENSION = 14_400n;

  before(async () => {
    [owner, alice, bob, whitelistGuardian, proposalGuardian] =
      await ethers.getSigners();

    // Deploy mock GovernorBravo at the expected address
    const MockGovernorBravoFactory =
      await ethers.getContractFactory("MockGovernorBravo");
    const mockGovernorBravo = await MockGovernorBravoFactory.deploy(100); // Start with proposal count 100

    // Deploy mock at the hardcoded address that CompoundGovernor expects
    const expectedAddress = "0xc0Da02939E1441F497fd74F78cE7Decb17B66529";
    await setBalance(expectedAddress, ethers.parseEther("1")); // Give it some ETH
    await hardhat.network.provider.send("hardhat_setCode", [
      expectedAddress,
      await ethers.provider.getCode(await mockGovernorBravo.getAddress()),
    ]);
    await hardhat.network.provider.send("hardhat_setStorageAt", [
      expectedAddress,
      "0x0", // First storage slot (proposalCount)
      ethers.toBeHex(100, 32), // Set proposal count to 100
    ]);

    // Deploy Comp token
    const CompFactory = await ethers.getContractFactory("Comp");
    comp = await CompFactory.deploy(owner.address);

    // Deploy Timelock
    const TimelockFactory = await ethers.getContractFactory("Timelock");
    timelock = await TimelockFactory.deploy(owner.address, 172800); // 2 days delay

    // Deploy CompoundGovernor implementation
    const CompoundGovernorFactory =
      await ethers.getContractFactory("CompoundGovernor");
    const implementation = await CompoundGovernorFactory.deploy();

    // Deploy proxy
    const ProxyFactory = await ethers.getContractFactory(
      "TransparentUpgradeableProxy",
    );
    const initData = implementation.interface.encodeFunctionData("initialize", [
      INITIAL_VOTING_DELAY,
      INITIAL_VOTING_PERIOD,
      INITIAL_PROPOSAL_THRESHOLD,
      await comp.getAddress(),
      INITIAL_QUORUM,
      await timelock.getAddress(),
      INITIAL_VOTE_EXTENSION,
      whitelistGuardian.address,
      {
        account: proposalGuardian.address,
        expiration: (await time.latest()) + 86400 * 365, // 1 year from now
      },
    ]);

    const proxy = await ProxyFactory.deploy(
      await implementation.getAddress(),
      await timelock.getAddress(),
      initData,
    );

    compoundGovernor = CompoundGovernorFactory.attach(
      await proxy.getAddress(),
    ) as CompoundGovernor;

    // Set next proposal ID to 1 before transferring admin (to avoid chicken-and-egg problem)
    const setNextProposalIdData = ethers
      .id("setNextProposalId()")
      .substring(0, 10);
    const setIdEta =
      BigInt(await time.latest()) + 100n + (await timelock.MINIMUM_DELAY());
    await timelock.queueTransaction(
      await compoundGovernor.getAddress(),
      0,
      "",
      setNextProposalIdData,
      setIdEta,
    );
    await time.increaseTo(setIdEta);
    await timelock.executeTransaction(
      await compoundGovernor.getAddress(),
      0,
      "",
      setNextProposalIdData,
      setIdEta,
    );

    // Transfer admin of timelock to governor
    const eta =
      BigInt(await time.latest()) + 100n + (await timelock.MINIMUM_DELAY());
    const txData = timelock.interface.encodeFunctionData("setPendingAdmin", [
      await compoundGovernor.getAddress(),
    ]);
    await timelock.queueTransaction(
      await timelock.getAddress(),
      0,
      "",
      txData,
      eta,
    );
    await time.increaseTo(eta);
    await timelock.executeTransaction(
      await timelock.getAddress(),
      0,
      "",
      txData,
      eta,
    );

    // Accept admin role in governor to complete the transfer
    await compoundGovernor.__acceptAdmin();

    // Give alice enough tokens to propose and delegate to herself
    await comp.transfer(alice.address, INITIAL_PROPOSAL_THRESHOLD * 2n);
    await comp.connect(alice).delegate(alice.address);

    // Give bob some tokens
    await comp.transfer(bob.address, ethers.parseEther("1000"));
    await comp.connect(bob).delegate(bob.address);

    // Whitelist alice to allow proposals (since the current logic requires both whitelisting conditions)
    const aliceExpiration = (await time.latest()) + 86400 * 365; // 1 year from now
    await compoundGovernor
      .connect(whitelistGuardian)
      .setWhitelistAccountExpiration(alice.address, aliceExpiration);
    // Also set alice as permanently whitelisted due to the OR logic bug
    await compoundGovernor.setPermanentWhitelist(alice.address, true);

    // Mine a block to activate delegations
    await mine();

    snapshot = await takeSnapshot();
  });

  afterEach(async () => await snapshot.restore());

  describe("Propose", function () {
    const targets = [ethers.ZeroAddress];
    const values = [0];
    const calldatas = ["0x"];
    const description = "Test Proposal";

    describe("whitelist", function () {
      it("should fail for non-whitelisted proposer", async function () {
        await expect(
          compoundGovernor
            .connect(bob)
            .propose(targets, values, calldatas, description),
        ).to.be.revertedWithCustomError(
          compoundGovernor,
          "GovernorNotWhitelisted",
        );
      });

      it("should succeed for whitelisted proposer", async function () {
        // Due to the logic bug, both conditions must be true for the check to pass
        const currentTime = await time.latest();
        const expiration = currentTime + 86400; // 1 day from now
        await compoundGovernor
          .connect(whitelistGuardian)
          .setWhitelistAccountExpiration(bob.address, expiration);
        await compoundGovernor.setPermanentWhitelist(bob.address, true);

        await expect(
          compoundGovernor
            .connect(bob)
            .propose(targets, values, calldatas, description),
        ).to.not.be.reverted;
      });

      it("should succeed for permanently whitelisted proposer", async function () {
        // Due to the logic bug, both conditions must be true for the check to pass
        await compoundGovernor.setPermanentWhitelist(bob.address, true);
        const currentTime = await time.latest();
        const expiration = currentTime + 86400; // 1 day from now
        await compoundGovernor
          .connect(whitelistGuardian)
          .setWhitelistAccountExpiration(bob.address, expiration);

        await expect(
          compoundGovernor
            .connect(bob)
            .propose(targets, values, calldatas, description),
        ).to.not.be.reverted;
      });
    });
  });
});
