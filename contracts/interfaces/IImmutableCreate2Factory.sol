// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface IImmutableCreate2Factory {
    function hasBeenDeployed(address deploymentAddress) external returns (bool);

    function findCreate2Address(bytes32 salt, bytes calldata initializationCode)
        external
        view
        returns (address deploymentAddress);

    function safeCreate2(bytes32 salt, bytes calldata initializationCode)
        external
        payable
        returns (address deploymentAddress);
}
