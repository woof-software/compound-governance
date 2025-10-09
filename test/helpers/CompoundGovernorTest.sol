// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.26;

import {Test, console2} from "forge-std/Test.sol";
import {ICompoundTimelock} from "@openzeppelin/contracts/vendor/compound/ICompoundTimelock.sol";
import {CompoundGovernorConstants} from "script/CompoundGovernorConstants.sol";
import {DeployCompoundGovernor} from "script/DeployCompoundGovernor.s.sol";
import {CompoundGovernor} from "contracts/CompoundGovernor.sol";
import {GovernorBravoDelegate} from "contracts/GovernorBravoDelegate.sol";
import {IComp} from "contracts/interfaces/IComp.sol";
import {IGovernor} from "contracts/extensions/IGovernor.sol";
import {GovernorCountingSimpleUpgradeable} from
    "@openzeppelin/contracts-upgradeable/governance/extensions/GovernorCountingSimpleUpgradeable.sol";
import {ProposeUpgradeBravoToCompoundGovernor} from "script/ProposeUpgradeBravoToCompoundGovernor.s.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract CompoundGovernorTest is Test, CompoundGovernorConstants {
    struct Proposal {
        address[] targets;
        uint256[] values;
        bytes[] calldatas;
        string description;
    }

    CompoundGovernor governor;
    IComp token;
    ICompoundTimelock timelock;
    address whitelistGuardian;
    CompoundGovernor.ProposalGuardian proposalGuardian;
    uint96 constant PROPOSAL_GUARDIAN_EXPIRY = 1_739_768_400;

    GovernorBravoDelegate public constant GOVERNOR_BRAVO = GovernorBravoDelegate(GOVERNOR_BRAVO_DELEGATE_ADDRESS);
    address public constant GOVERNOR_BRAVO_PROXY_ADDRESS = 0x6F6e4785c97885d26466945055d4Ae8931bE6f7a;
    address public constant PROXY_ADMIN = 0x725ED7F44F0888aeC1b7630AB1ACdced91E0591A;

    function setUp() public virtual {
        // set the RPC URL and the fork block number to create a local execution fork for testing
        vm.createSelectFork(vm.envOr("RPC_URL", string("Please set RPC_URL in your .env file")), FORK_BLOCK);

        if (_useDeployedCompoundGovernor()) {
            // Set the governor to be the deployed CompoundGovernor
            governor = CompoundGovernor(payable(DEPLOYED_UPGRADE_CANDIDATE));
            whitelistGuardian = governor.whitelistGuardian();
            (proposalGuardian.account, proposalGuardian.expiration) = governor.proposalGuardian();
        } else {
            whitelistGuardian = makeAddr("WHITELIST_GUARDIAN_ADDRESS");
            proposalGuardian = CompoundGovernor.ProposalGuardian(COMMUNITY_MULTISIG_ADDRESS, PROPOSAL_GUARDIAN_EXPIRY);

            // Deploy the CompoundGovernor contract
            DeployCompoundGovernor _deployer = new DeployCompoundGovernor();
            _deployer.setUp();
            governor = _deployer.run(whitelistGuardian, proposalGuardian);
        }
        timelock = ICompoundTimelock(payable(governor.timelock()));
        token = governor.token();

        // make the new governor the admin of the timelock
        if (_shouldPassAndExecuteUpgradeProposal()) {
            _updateTimelockAdminToNewGovernor(governor);
        }

        vm.label(GOVERNOR_BRAVO_DELEGATE_ADDRESS, "GovernorBravoDelegate");
        vm.label(address(governor), "CompoundGovernor");
        vm.label(address(timelock), "Timelock");
        vm.label(COMP_TOKEN_ADDRESS, "CompToken");
    }

    function _encodeStateBitmap(IGovernor.ProposalState proposalState) internal pure returns (bytes32) {
        return bytes32(1 << uint8(proposalState));
    }

    function _useDeployedCompoundGovernor() internal pure virtual returns (bool) {
        return false;
    }

    function _shouldPassAndExecuteUpgradeProposal() internal pure virtual returns (bool) {
        return true;
    }

    function _timelockOrWhitelistGuardian(uint256 _randomSeed) internal view returns (address) {
        return _randomSeed % 2 == 0 ? TIMELOCK_ADDRESS : whitelistGuardian;
    }

    /* Begin CompoundGovernor-related helper methods */

    function _getProposalId(Proposal memory _proposal) internal returns (uint256) {
        return governor.hashProposal(
            _proposal.targets, _proposal.values, _proposal.calldatas, keccak256(bytes(_proposal.description))
        );
    }

    function _buildProposalData(string memory _signature, bytes memory _calldata)
        internal
        pure
        returns (bytes memory)
    {
        return abi.encodePacked(bytes4(keccak256(bytes(_signature))), _calldata);
    }

    function _buildAnEmptyProposal() internal pure returns (Proposal memory _proposal) {
        address[] memory _targets = new address[](1);
        uint256[] memory _values = new uint256[](1);
        bytes[] memory _calldatas = new bytes[](1);
        _proposal = Proposal(_targets, _values, _calldatas, "An Empty Proposal");
    }

    function _assumeSafeReceiver(address _to) public pure {
        vm.assume(_to != address(0));
    }

    function _getRandomProposer() internal returns (address) {
        return _majorDelegates[vm.randomUint(0, _majorDelegates.length - 1)];
    }

    function _setWhitelistedProposer(address _proposer) public {
        vm.prank(whitelistGuardian);
        governor.setWhitelistAccountExpiration(_proposer, block.timestamp + 2_000_000);
    }

    function _setWhitelistedProposerViaAllowedProposer(address _proposer) public {
        address[] memory _allowedProposers = governor.getAllowedProposers();
        require(_allowedProposers.length > 0, "No allowed proposers");

        // Skip if the proposer is already an allowed proposer (can't whitelist allowed proposers)
        if (governor.isAllowedProposer(_proposer)) {
            return;
        }

        address _allowedProposer = _allowedProposers[0]; // Get first allowed proposer
        vm.prank(_allowedProposer);
        governor.setWhitelistAccountExpiration(_proposer, block.timestamp + 2_000_000);
    }

    function _addToAllowedProposers(address _proposer) public {
        // Check if proposer is already in the allowed list
        if (governor.isAllowedProposer(_proposer)) {
            return; // Already in the list, nothing to do
        }

        // Need to first add a major delegate to allowed proposers if none exist
        address[] memory _currentAllowed = governor.getAllowedProposers();
        if (_currentAllowed.length == 0) {
            // Bootstrap: directly add a major delegate through timelock
            vm.prank(TIMELOCK_ADDRESS);
            governor.addProposer(_majorDelegates[0]);
            _currentAllowed = governor.getAllowedProposers();
        }

        // If the proposer we want to add is already bootstrapped, use direct timelock addition
        // to avoid governance proposal complexity
        if (_proposer == _majorDelegates[0]) {
            return; // Already added in bootstrap
        }

        // For any other proposer, we can add them directly through timelock for testing purposes
        // This avoids the complexity of governance proposals in test helpers
        vm.prank(TIMELOCK_ADDRESS);
        governor.addProposer(_proposer);
    }

    function _removeFromAllowedProposers(address _proposer) public {
        address[] memory _currentAllowed = governor.getAllowedProposers();
        require(_currentAllowed.length > 0, "No allowed proposers");

        Proposal memory _proposal = _buildRemoveProposerProposal(_proposer);
        _submitPassQueueAndExecuteProposal(_currentAllowed[0], _proposal);
    }

    function _buildAddProposerProposal(address _proposer) internal view returns (Proposal memory _proposal) {
        address[] memory _targets = new address[](1);
        _targets[0] = address(governor);

        uint256[] memory _values = new uint256[](1);
        _values[0] = 0;

        bytes[] memory _calldatas = new bytes[](1);
        _calldatas[0] = abi.encodeWithSelector(CompoundGovernor.addProposer.selector, _proposer);

        _proposal = Proposal(_targets, _values, _calldatas, "Add Proposer to Allowed List");
    }

    function _buildRemoveProposerProposal(address _proposer) internal view returns (Proposal memory _proposal) {
        address[] memory _targets = new address[](1);
        _targets[0] = address(governor);

        uint256[] memory _values = new uint256[](1);
        _values[0] = 0;

        bytes[] memory _calldatas = new bytes[](1);
        _calldatas[0] = abi.encodeWithSelector(CompoundGovernor.removeProposer.selector, _proposer);

        _proposal = Proposal(_targets, _values, _calldatas, "Remove Proposer from Allowed List");
    }

    function _submitProposal(Proposal memory _proposal) public returns (uint256 _proposalId) {
        vm.prank(_getRandomProposer());
        _proposalId = governor.propose(_proposal.targets, _proposal.values, _proposal.calldatas, _proposal.description);

        vm.roll(vm.getBlockNumber() + INITIAL_VOTING_DELAY + 1);
    }

    function _submitProposal(address _proposer, Proposal memory _proposal) public returns (uint256 _proposalId) {
        vm.prank(_proposer);
        _proposalId = governor.propose(_proposal.targets, _proposal.values, _proposal.calldatas, _proposal.description);

        vm.roll(vm.getBlockNumber() + INITIAL_VOTING_DELAY + 1);
    }

    function _submitProposalWithoutRoll(address _proposer, Proposal memory _proposal)
        public
        returns (uint256 _proposalId)
    {
        vm.prank(_proposer);
        _proposalId = governor.propose(_proposal.targets, _proposal.values, _proposal.calldatas, _proposal.description);
    }

    function _passProposal(uint256 _proposalId) public {
        for (uint256 _index = 0; _index < _majorDelegates.length; _index++) {
            vm.prank(_majorDelegates[_index]);
            governor.castVote(_proposalId, uint8(GovernorCountingSimpleUpgradeable.VoteType.For));
        }
        vm.roll(vm.getBlockNumber() + INITIAL_VOTING_PERIOD + 1);
    }

    function _queueProposal(Proposal memory _proposal) public {
        governor.queue(
            _proposal.targets, _proposal.values, _proposal.calldatas, keccak256(bytes(_proposal.description))
        );
    }

    function _passAndQueueProposal(Proposal memory _proposal, uint256 _proposalId) public {
        uint256 _timeLockDelay = timelock.delay();
        _passProposal(_proposalId);
        governor.queue(
            _proposal.targets, _proposal.values, _proposal.calldatas, keccak256(bytes(_proposal.description))
        );

        vm.warp(block.timestamp + _timeLockDelay + 1);
    }

    function _passQueueAndExecuteProposal(uint256 _proposalId) public {
        uint256 _timeLockDelay = timelock.delay();
        for (uint256 _index = 0; _index < _majorDelegates.length; _index++) {
            vm.prank(_majorDelegates[_index]);
            governor.castVote(_proposalId, uint8(GovernorCountingSimpleUpgradeable.VoteType.For));
        }

        vm.roll(vm.getBlockNumber() + INITIAL_VOTING_PERIOD + 1);
        governor.queue(_proposalId);

        vm.warp(block.timestamp + _timeLockDelay + 1);
        governor.execute(_proposalId);
    }

    function _passQueueAndExecuteProposal(Proposal memory _proposal, uint256 _proposalId) public {
        uint256 _timeLockDelay = timelock.delay();
        for (uint256 _index = 0; _index < _majorDelegates.length; _index++) {
            vm.prank(_majorDelegates[_index]);
            governor.castVote(_proposalId, uint8(GovernorCountingSimpleUpgradeable.VoteType.For));
        }

        vm.roll(vm.getBlockNumber() + INITIAL_VOTING_PERIOD + 1);
        governor.queue(
            _proposal.targets, _proposal.values, _proposal.calldatas, keccak256(bytes(_proposal.description))
        );

        vm.warp(block.timestamp + _timeLockDelay + 1);
        governor.execute(
            _proposal.targets, _proposal.values, _proposal.calldatas, keccak256(bytes(_proposal.description))
        );
    }

    function _failProposal(uint256 _proposalId) public {
        for (uint256 _index = 0; _index < _majorDelegates.length; _index++) {
            vm.prank(_majorDelegates[_index]);
            governor.castVote(_proposalId, uint8(GovernorCountingSimpleUpgradeable.VoteType.Against));
        }

        vm.roll(vm.getBlockNumber() + INITIAL_VOTING_PERIOD + 1);
    }

    function _submitAndPassProposal(address _proposer, Proposal memory _proposal) public returns (uint256) {
        uint256 _proposalId = _submitProposal(address(_proposer), _proposal);
        _passProposal(uint256(_proposalId));

        return _proposalId;
    }

    function _submitPassAndQueueProposal(address _proposer, Proposal memory _proposal) public returns (uint256) {
        uint256 _proposalId = _submitProposal(_proposer, _proposal);
        _passAndQueueProposal(_proposal, _proposalId);
        return _proposalId;
    }

    function _submitPassQueueAndExecuteProposal(address _proposer, Proposal memory _proposal)
        public
        returns (uint256)
    {
        uint256 _proposalId = _submitProposal(_proposer, _proposal);
        _passQueueAndExecuteProposal(_proposal, _proposalId);
        return _proposalId;
    }

    function _submitPassQueueAndExpectExecutionToRevert(address _proposer, Proposal memory _proposal)
        public
        returns (uint256)
    {
        uint256 _proposalId = _submitProposal(_proposer, _proposal);
        _passAndQueueProposal(_proposal, _proposalId);

        // Wait for timelock delay
        vm.warp(governor.proposalEta(_proposalId) + 1);

        // Now expect the execution to revert
        vm.expectRevert();
        governor.execute(
            _proposal.targets, _proposal.values, _proposal.calldatas, keccak256(bytes(_proposal.description))
        );

        return _proposalId;
    }

    function _submitAndFailProposal(address _proposer, Proposal memory _proposal) public returns (uint256) {
        uint256 _proposalId = _submitProposal(_proposer, _proposal);
        _failProposal(_proposalId);
        return _proposalId;
    }

    function _buildNewGovernorSetVotingDelayProposal(uint48 _amount)
        internal
        view
        returns (Proposal memory _proposal)
    {
        address[] memory _targets = new address[](1);
        _targets[0] = address(governor);

        uint256[] memory _values = new uint256[](1);
        _values[0] = 0;

        bytes[] memory _calldatas = new bytes[](1);
        _calldatas[0] = _buildProposalData("setVotingDelay(uint48)", abi.encode(_amount));

        _proposal = Proposal(_targets, _values, _calldatas, "Set New Voting Delay on New Compound Governor");
    }

    function _buildAndSubmitOldGovernorSetVotingDelayProposal(uint256 _proposerIndex, uint256 _amount)
        internal
        returns (uint256 _proposalId)
    {
        vm.assume(_amount >= GOVERNOR_BRAVO.MIN_VOTING_DELAY() && _amount <= GOVERNOR_BRAVO.MAX_VOTING_DELAY());
        _proposerIndex = bound(_proposerIndex, 0, _majorDelegates.length - 1);
        address[] memory _targets = new address[](1);
        uint256[] memory _values = new uint256[](1);
        string[] memory _signatures = new string[](1);
        bytes[] memory _calldatas = new bytes[](1);

        _targets[0] = GOVERNOR_BRAVO_DELEGATE_ADDRESS;
        _values[0] = 0;
        _signatures[0] = "_setVotingDelay(uint256)";
        _calldatas[0] = abi.encode(uint256(_amount));

        vm.prank(_majorDelegates[0]);
        return
            GOVERNOR_BRAVO.propose(_targets, _values, _signatures, _calldatas, "Set Voting Delay on Old Governor Bravo");
    }

    /* End CompoundGovernor-related helper methods */

    /* Begin Bravo-related helper methods */

    function _updateTimelockAdminToNewGovernor(CompoundGovernor _newGovernor) internal {
        ProposeUpgradeBravoToCompoundGovernor _proposeUpgrade = new ProposeUpgradeBravoToCompoundGovernor();

        // runs the script to propose the upgrade
        uint256 _upgradeProposalId = _proposeUpgrade.run(_newGovernor);

        // manage the votes to pass the upgrade proposal
        _passQueueAndExecuteBravoProposal(_upgradeProposalId);
    }

    function _getBravoProposalStartBlock(uint256 _bravoProposalId) internal view returns (uint256) {
        (,,, uint256 _startBlock,,,,,,) = GOVERNOR_BRAVO.proposals(_bravoProposalId);
        return _startBlock;
    }

    function _getBravoProposalEndBlock(uint256 _bravoProposalId) internal view returns (uint256) {
        (,,,, uint256 _endBlock,,,,,) = GOVERNOR_BRAVO.proposals(_bravoProposalId);
        return _endBlock;
    }

    function _jumpToActiveBravoProposal(uint256 _bravoProposalId) internal {
        vm.roll(_getBravoProposalStartBlock(_bravoProposalId) + 1);
    }

    function _jumpToBravoVoteComplete(uint256 _bravoProposalId) internal {
        vm.roll(_getBravoProposalEndBlock(_bravoProposalId) + 1);
    }

    function _delegatesVoteOnBravoProposal(
        uint256 _bravoProposalId,
        GovernorCountingSimpleUpgradeable.VoteType _support
    ) internal {
        for (uint256 _index = 0; _index < _majorDelegates.length; _index++) {
            vm.prank(_majorDelegates[_index]);
            GOVERNOR_BRAVO.castVote(_bravoProposalId, uint8(_support));
        }
    }

    function _getBravoProposalEta(uint256 _bravoProposalId) internal view returns (uint256) {
        (,, uint256 _eta,,,,,,,) = GOVERNOR_BRAVO.proposals(_bravoProposalId);
        return _eta;
    }

    function _jumpPastBravoProposalEta(uint256 _bravoProposalId) internal {
        vm.roll(vm.getBlockNumber() + 1); // move up one block so not in the same block as when queued
        vm.warp(_getBravoProposalEta(_bravoProposalId) + 1); // jump past the eta timestamp
    }

    function _passBravoProposal(uint256 _bravoProposalId) internal {
        _jumpToActiveBravoProposal(_bravoProposalId);
        _delegatesVoteOnBravoProposal(_bravoProposalId, GovernorCountingSimpleUpgradeable.VoteType.For);
        _jumpToBravoVoteComplete(_bravoProposalId);
    }

    function _failBravoProposal(uint256 _bravoProposalId) internal {
        _jumpToActiveBravoProposal(_bravoProposalId);
        _delegatesVoteOnBravoProposal(_bravoProposalId, GovernorCountingSimpleUpgradeable.VoteType.Against);
        _jumpToBravoVoteComplete(_bravoProposalId);
    }

    function _passAndQueueBravoProposal(uint256 _bravoProposalId) internal {
        _passBravoProposal(_bravoProposalId);
        GOVERNOR_BRAVO.queue(_bravoProposalId);
    }

    function _passQueueAndExecuteBravoProposal(uint256 _bravoProposalId) public {
        _passAndQueueBravoProposal(_bravoProposalId);
        _jumpPastBravoProposalEta(_bravoProposalId);
        GOVERNOR_BRAVO.execute(_bravoProposalId);
    }

    function _upgradeFromBravoToCompoundGovernorViaProposalVote() internal {
        // Create the proposal to upgrade the Bravo governor to the CompoundGovernor
        ProposeUpgradeBravoToCompoundGovernor _proposeUpgrade = new ProposeUpgradeBravoToCompoundGovernor();
        uint256 _upgradeProposalId = _proposeUpgrade.run(governor);

        // Pass, queue, and execute the proposal
        _passQueueAndExecuteBravoProposal(_upgradeProposalId);
    }

    function _failProposalVoteForUpgradeFromBravoToCompoundGovernor() internal {
        // Create the proposal to upgrade the Bravo governor to the CompoundGovernor
        ProposeUpgradeBravoToCompoundGovernor _proposeUpgrade = new ProposeUpgradeBravoToCompoundGovernor();
        uint256 _upgradeProposalId = _proposeUpgrade.run(governor);

        // Pass, queue, and execute the proposal
        _failBravoProposal(_upgradeProposalId);
    }

    /*//////////////////////////////////////////////////////////////
                    UPGRADE COMPOUND GOVERNOR HELPERS
    //////////////////////////////////////////////////////////////*/

    // Common setup for upgrade tests
    function _setupUpgradeTest()
        internal
        returns (CompoundGovernor newGovernor, CompoundGovernor governor, ICompoundTimelock timelock)
    {
        vm.createSelectFork(vm.envString("RPC_URL"));

        // Deploy new CompoundGovernor implementation
        newGovernor = new CompoundGovernor();

        // Get the existing governor proxy address (this should be the deployed CompoundGovernor)
        governor = CompoundGovernor(payable(GOVERNOR_PROXY_ADDRESS));

        // Get the timelock from the governor
        address timelockAddress = governor.timelock();
        timelock = ICompoundTimelock(payable(timelockAddress));
    }

    // Create upgrade proposal
    function _createUpgradeProposal(CompoundGovernor _newGovernor)
        internal
        pure
        returns (CompoundGovernorTest.Proposal memory)
    {
        address[] memory _targets = new address[](1);
        _targets[0] = PROXY_ADMIN_ADDRESS;

        uint256[] memory _values = new uint256[](1);
        _values[0] = 0;

        bytes[] memory _calldatas = new bytes[](1);
        _calldatas[0] = abi.encodeWithSelector(
            ProxyAdmin.upgradeAndCall.selector, GOVERNOR_PROXY_ADDRESS, address(_newGovernor), ""
        );

        return CompoundGovernorTest.Proposal(
            _targets,
            _values,
            _calldatas,
            "Upgrade Governor from current implementation to new CompoundGovernor implementation"
        );
    }

    // Whitelist proposer if needed
    function _whitelistProposerIfNeeded(CompoundGovernor governor, address proposer) internal {
        // Check if proposer is already whitelisted
        if (governor.isWhitelisted(proposer)) {
            return; // Already whitelisted, nothing to do
        }
        // For the current implementation, we need to whitelist the proposer
        // This requires calling setWhitelistAccountExpiration through the timelock
        uint256 expiration = block.timestamp + 365 days; // Whitelist for 1 year
        vm.prank(TIMELOCK_ADDRESS);
        governor.setWhitelistAccountExpiration(proposer, expiration);
    }

    // Submit and pass proposal
    function _submitAndPassProposal(
        CompoundGovernor governor,
        CompoundGovernorTest.Proposal memory upgradeProposal,
        address proposer
    ) internal returns (uint256 _proposalId) {
        // Propose the upgrade
        vm.prank(proposer);
        _proposalId = governor.propose(
            upgradeProposal.targets, upgradeProposal.values, upgradeProposal.calldatas, upgradeProposal.description
        );
        vm.roll(vm.getBlockNumber() + INITIAL_VOTING_DELAY + 1);

        // Pass the proposal
        for (uint256 _index = 0; _index < _majorDelegates.length; _index++) {
            vm.prank(_majorDelegates[_index]);
            governor.castVote(_proposalId, uint8(GovernorCountingSimpleUpgradeable.VoteType.For));
        }
        vm.roll(vm.getBlockNumber() + INITIAL_VOTING_PERIOD + 1);

        // Queue the proposal
        governor.queue(_proposalId);
    }

    // Execute proposal
    function _executeProposal(CompoundGovernor governor, ICompoundTimelock timelock, uint256 _proposalId) internal {
        // Wait for timelock delay and execute
        vm.warp(block.timestamp + timelock.delay() + 1);
        governor.execute(_proposalId);
    }

    // Storage snapshot structure
    struct StorageSnapshot {
        uint256 votingDelay;
        uint256 votingPeriod;
        uint256 proposalThreshold;
        uint256 quorum;
        uint48 voteExtension;
        address tokenAddress;
        address timelockAddr;
        address whitelistGuardianAddr;
        address proposalGuardianAccount;
        uint96 proposalGuardianExpiry;
    }

    // Capture storage before upgrade
    function _captureStorageSnapshot(CompoundGovernor governor) internal view returns (StorageSnapshot memory) {
        (address proposalGuardianAccount, uint96 proposalGuardianExpiry) = governor.proposalGuardian();

        return StorageSnapshot({
            votingDelay: governor.votingDelay(),
            votingPeriod: governor.votingPeriod(),
            proposalThreshold: governor.proposalThreshold(),
            quorum: governor.quorum(block.timestamp),
            voteExtension: governor.lateQuorumVoteExtension(),
            tokenAddress: address(governor.token()),
            timelockAddr: governor.timelock(),
            whitelistGuardianAddr: governor.whitelistGuardian(),
            proposalGuardianAccount: proposalGuardianAccount,
            proposalGuardianExpiry: proposalGuardianExpiry
        });
    }

    // Assert storage consistency after upgrade
    function _assertStorageConsistency(StorageSnapshot memory before, CompoundGovernor governor) internal view {
        StorageSnapshot memory afterSnapshot = _captureStorageSnapshot(governor);

        // Core governance settings should remain unchanged
        assertEq(before.votingDelay, afterSnapshot.votingDelay, "Voting delay changed after upgrade");
        assertEq(before.votingPeriod, afterSnapshot.votingPeriod, "Voting period changed after upgrade");
        assertEq(before.proposalThreshold, afterSnapshot.proposalThreshold, "Proposal threshold changed after upgrade");
        assertEq(before.quorum, afterSnapshot.quorum, "Quorum changed after upgrade");
        assertEq(before.voteExtension, afterSnapshot.voteExtension, "Vote extension changed after upgrade");

        // Token and timelock addresses should remain unchanged
        assertEq(before.tokenAddress, afterSnapshot.tokenAddress, "Token address changed after upgrade");
        assertEq(before.timelockAddr, afterSnapshot.timelockAddr, "Timelock address changed after upgrade");

        // Whitelist and proposal guardian settings should remain unchanged
        assertEq(
            before.whitelistGuardianAddr,
            afterSnapshot.whitelistGuardianAddr,
            "Whitelist guardian changed after upgrade"
        );
        assertEq(
            before.proposalGuardianAccount,
            afterSnapshot.proposalGuardianAccount,
            "Proposal guardian account changed after upgrade"
        );
        assertEq(
            before.proposalGuardianExpiry,
            afterSnapshot.proposalGuardianExpiry,
            "Proposal guardian expiry changed after upgrade"
        );
    }

    // Verify basic functionality after upgrade
    function _verifyBasicFunctionality(CompoundGovernor governor) internal view {
        assertTrue(address(governor.token()) != address(0), "Token address should not be zero");
        assertTrue(governor.timelock() != address(0), "Timelock address should not be zero");
        assertTrue(governor.votingDelay() > 0, "Voting delay should be greater than zero");
        assertTrue(governor.votingPeriod() > 0, "Voting period should be greater than zero");
    }
}
