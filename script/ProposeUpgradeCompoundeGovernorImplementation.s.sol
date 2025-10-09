// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Script, console2 } from "forge-std/Script.sol";
import { CompoundGovernor } from "contracts/CompoundGovernor.sol";
import { CompoundGovernorConstants } from "script/CompoundGovernorConstants.sol";
import { ProxyAdmin } from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

/// @notice Script to submit a proposal to upgrade the CompoundGovernor implementation.
/// @dev This script creates a proposal to upgrade the current CompoundGovernor implementation
///      to a new implementation contract. The proposer must be whitelisted or an allowed proposer.
contract ProposeUpgradeCompoundeGovernorImplementation is
    Script,
    CompoundGovernorConstants
{
    /// @notice The current CompoundGovernor proxy address on mainnet
    /// @dev This should be updated with the actual deployed CompoundGovernor proxy address
    address public constant COMPOUND_GOVERNOR_PROXY =
        0x309a862bbC1A00e45506cB8A802D1ff10004c8C0;

    /// @notice Proposes an upgrade to the CompoundGovernor implementation
    /// @param _newImplementation The address of the new CompoundGovernor implementation
    /// @return _proposalId The ID of the created proposal
    function propose(
        CompoundGovernor _newImplementation
    ) internal returns (uint256 _proposalId) {
        // Get the current governor instance
        CompoundGovernor governor = CompoundGovernor(
            payable(COMPOUND_GOVERNOR_PROXY)
        );

        (address _proposalGuardian, ) = governor.proposalGuardian();
        // Prepare addresses for batchWhitelist call
        // First address must be proposalGuardian (COMMUNITY_MULTISIG_ADDRESS)
        address[] memory _initProposers = new address[](13);
        _initProposers[0] = _proposalGuardian; // proposalGuardian
        _initProposers[1] = 0xb06DF4dD01a5c5782f360aDA9345C87E86ADAe3D; // Compound Foundation
        _initProposers[2] = 0xd2A79F263eC55DBC7B724eCc20FC7448D4795a0C; // WOOF!
        _initProposers[3] = 0x3FB19771947072629C8EEE7995a2eF23B72d4C8A; // PGov
        _initProposers[4] = 0x0579A616689f7ed748dC07692A3F150D44b0CA09; // Arana
        _initProposers[5] = 0x683a4F9915D6216f73d6Df50151725036bD26C02; // Gauntlet
        _initProposers[6] = 0xB49f8b8613bE240213C1827e2E576044fFEC7948; // Avantgarde
        _initProposers[7] = 0x13BDaE8c5F0fC40231F0E6A4ad70196F59138548; // Michigan Blockchain
        _initProposers[8] = 0x070341aA5Ed571f0FB2c4a5641409B1A46b4961b; // FranklinDAO
        _initProposers[9] = 0x66cD62c6F8A4BB0Cd8720488BCBd1A6221B765F9; // allthecolors
        _initProposers[10] = 0x2B384212EDc04Ae8bB41738D05BA20E33277bf33; // Arr00
        _initProposers[11] = 0xB933AEe47C438f22DE0747D57fc239FE37878Dd1; // Wintermute

        /*//////////////////////////////////////////////////////////////
                                    PENDING
        //////////////////////////////////////////////////////////////*/
        _initProposers[12] = 0x9AA835Bc7b8cE13B9B0C9764A52FbF71AC62cCF1; // a16z

        // Encode the batchWhitelist call data
        bytes memory _batchWhitelistCalldata = abi.encodeWithSelector(
            CompoundGovernor.batchWhitelist.selector,
            _initProposers
        );

        // Create proposal targets - we need to call the proxy admin to upgrade
        address[] memory _targets = new address[](1);
        _targets[0] = PROXY_ADMIN_ADDRESS;

        uint256[] memory _values = new uint256[](1);
        _values[0] = 0;

        bytes[] memory _calldatas = new bytes[](1);
        _calldatas[0] = abi.encodeWithSelector(
            ProxyAdmin.upgradeAndCall.selector,
            COMPOUND_GOVERNOR_PROXY,
            address(_newImplementation),
            _batchWhitelistCalldata
        );

        string memory _description = "Upgrade CompoundGovernor Implementation\n\n"
        "This proposal upgrades the CompoundGovernor implementation to a new version.\n\n"
        "The upgrade will:\n"
        "- Deploy a new CompoundGovernor implementation contract\n"
        "- Update the proxy to point to the new implementation\n"
        "- Initialize the allowed proposers list with 13 addresses:\n"
        "  * Proposal Guardian (current guardian address)\n"
        "  * Compound Foundation (0xb06DF4dD01a5c5782f360aDA9345C87E86ADAe3D)\n"
        "  * WOOF! (0xd2A79F263eC55DBC7B724eCc20FC7448D4795a0C)\n"
        "  * PGov (0x3FB19771947072629C8EEE7995a2eF23B72d4C8A)\n"
        "  * Arana (0x0579A616689f7ed748dC07692A3F150D44b0CA09)\n"
        "  * Gauntlet (0x683a4F9915D6216f73d6Df50151725036bD26C02)\n"
        "  * Avantgarde (0xB49f8b8613bE240213C1827e2E576044fFEC7948)\n"
        "  * Michigan Blockchain (0x13BDaE8c5F0fC40231F0E6A4ad70196F59138548)\n"
        "  * FranklinDAO (0x070341aA5Ed571f0FB2c4a5641409B1A46b4961b)\n"
        "  * allthecolors (0x66cD62c6F8A4BB0Cd8720488BCBd1A6221B765F9)\n"
        "  * Arr00 (0x2B384212EDc04Ae8bB41738D05BA20E33277bf33)\n"
        "  * Wintermute (0xB933AEe47C438f22DE0747D57fc239FE37878Dd1)\n"
        "  * a16z (0x9AA835Bc7b8cE13B9B0C9764A52FbF71AC62cCF1)\n"
        "- Preserve all existing storage and state\n"
        "- Maintain all current governance parameters and settings\n\n"
        "This upgrade includes the new allowed proposers system that replaces the whitelist\n"
        "mechanism with a more structured approach for managing proposal creation rights.\n\n"
        "The upgrade will be executed through the existing proxy admin, ensuring a safe\n"
        "transition to the new implementation while preserving all current state.";

        return governor.propose(_targets, _values, _calldatas, _description);
    }

    /// @notice Main function to run the script
    /// @param _newImplementation The address of the new CompoundGovernor implementation
    /// @return _proposalId The ID of the created proposal
    function run(
        CompoundGovernor _newImplementation
    ) public returns (uint256 _proposalId) {
        // The expectation is the key loaded here corresponds to the address of the `proposer` above.
        // When running as a script, broadcast will fail if the key is not correct.
        // These default addresses are the anvils default account #0, if no environment variable is set, meant just for
        // testing.
        uint256 _proposerKey = vm.envOr(
            "PROPOSER_PRIVATE_KEY",
            uint256(
                0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
            )
        );
        address _proposerAddress = vm.envOr(
            "PROPOSER_ADDRESS",
            _majorDelegates[0]
        );
        vm.rememberKey(_proposerKey);

        vm.startBroadcast(_proposerAddress);
        _proposalId = propose(_newImplementation);
        vm.stopBroadcast();

        // Log the proposal ID for reference
        console2.log("Proposal created with ID:", _proposalId);
        console2.log("Proposer address:", _proposerAddress);
        console2.log(
            "New implementation address:",
            address(_newImplementation)
        );

        return _proposalId;
    }
}
