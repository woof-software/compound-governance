// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface ITransparentUpgradeableProxy {
    function upgradeToAndCall(address newImplementation, bytes calldata data) external payable;
}

interface IProxyAdmin {
    function upgradeAndCall(
        ITransparentUpgradeableProxy proxy,
        address implementation,
        bytes memory data
    ) external payable;
}
