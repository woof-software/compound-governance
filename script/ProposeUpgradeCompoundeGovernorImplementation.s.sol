// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Script, console2 } from "forge-std/Script.sol";
import { CompoundGovernor } from "contracts/CompoundGovernor.sol";
import { CompoundGovernorConstants } from "script/CompoundGovernorConstants.sol";
import { IProxyAdmin } from "contracts/interfaces/IProxyAdmin.sol";

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

        // Create proposal targets - we need to call the proxy admin to upgrade
        address[] memory _targets = new address[](1);
        _targets[0] = PROXY_ADMIN_ADDRESS;

        uint256[] memory _values = new uint256[](1);
        _values[0] = 0;

        bytes[] memory _calldatas = new bytes[](1);
        _calldatas[0] = abi.encodeWithSelector(
            IProxyAdmin.upgradeAndCall.selector,
            COMPOUND_GOVERNOR_PROXY,
            address(_newImplementation),
            ""
        );

        string memory _description = "Upgrade CompoundGovernor Implementation\n\n"
        "This proposal upgrades the CompoundGovernor implementation to a new version.\n\n"
        "The upgrade will:\n"
        "- Deploy a new CompoundGovernor implementation contract\n"
        "- Update the proxy to point to the new implementation\n"
        "- Preserve all existing storage and state\n"
        "- Maintain all current governance parameters and settings\n\n"
        "This is a standard implementation upgrade that does not change the governance logic,\n"
        "but may include bug fixes, optimizations, or minor feature improvements.\n\n"
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
        // Get the proposer's private key from environment variables
        // The proposer must be whitelisted or an allowed proposer
        uint256 _proposerKey = vm.envOr(
            "PROPOSER_PRIVATE_KEY",
            uint256(
                0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
            )
        );

        // Get the proposer address from environment or use first major delegate
        address _proposerAddress = vm.envOr(
            "PROPOSER_ADDRESS",
            _majorDelegates[0]
        );

        // Remember the private key for broadcasting
        vm.rememberKey(_proposerKey);

        // Start broadcasting from the proposer address
        vm.startBroadcast(_proposerAddress);

        // Create and submit the proposal
        _proposalId = propose(_newImplementation);

        vm.stopBroadcast();

        // Log the proposal ID for reference
        console2.log("Proposal created with ID:", _proposalId);
        console2.log("Proposer address:", _proposerAddress);
        console2.log(
            "New implementation address:",
            address(_newImplementation)
        );
        console2.log("Governor proxy address:", COMPOUND_GOVERNOR_PROXY);

        return _proposalId;
    }

    /// @notice Alternative run function that deploys a new implementation and proposes the upgrade
    /// @dev This function can be used if you want to deploy a new implementation as part of the script
    /// @return _proposalId The ID of the created proposal
    function runWithNewDeployment() public returns (uint256 _proposalId) {
        // Get the proposer's private key from environment variables
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

        // Deploy a new CompoundGovernor implementation
        CompoundGovernor _newImplementation = new CompoundGovernor();

        // Create and submit the proposal
        _proposalId = propose(_newImplementation);

        vm.stopBroadcast();

        console2.log(
            "New implementation deployed at:",
            address(_newImplementation)
        );
        console2.log("Proposal created with ID:", _proposalId);
        console2.log("Proposer address:", _proposerAddress);

        return _proposalId;
    }
}
