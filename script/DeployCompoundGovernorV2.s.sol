// SPDX-License-Identifier: BSD-3-Clause
// slither-disable-start reentrancy-benign

pragma solidity 0.8.26;

import { Script, console } from "forge-std/Script.sol";
import { CompoundGovernor } from "contracts/CompoundGovernor.sol";
import { CompoundGovernorConstants } from "script/CompoundGovernorConstants.sol";

// Deploy script for the CompoundGovernor Implementation that will be used by the proxy
contract DeployCompoundGovernorV2 is Script, CompoundGovernorConstants {
    uint256 deployerPrivateKey;

    function setUp() public virtual {
        // private key of the deployer (use the anvil default account #0 key, if no environment variable is set)
        deployerPrivateKey = vm.envOr(
            "DEPLOYER_PRIVATE_KEY",
            uint256(
                0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
            )
        );
    }

    function run() public returns (address _governor) {
        vm.startBroadcast(deployerPrivateKey);

        // Deploy Governor implementation contract
        CompoundGovernor _governorImplementation = new CompoundGovernor();

        console.log("CompoundGovernor V2 deployed successfully!");
        console.log(
            "Implementation address:",
            address(_governorImplementation)
        );

        _governor = address(_governorImplementation);
        vm.stopBroadcast();
    }
}
