// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Scripting tool
import {Script} from "../../lib/forge-std/src/Script.sol";

// Core contracts
import {TransferManager} from "../../contracts/TransferManager.sol";

// Create2 factory interface
import {IImmutableCreate2Factory} from "../../contracts/interfaces/IImmutableCreate2Factory.sol";

contract Deployment is Script {
    IImmutableCreate2Factory private constant IMMUTABLE_CREATE2_FACTORY =
        IImmutableCreate2Factory(0x0000000000FFe8B47B3e2130213B802212439497);

    error ChainIdInvalid(uint256 chainId);

    function run() external {
        uint256 chainId = block.chainid;
        uint256 deployerPrivateKey;

        address owner;

        if (chainId == 1) {
            deployerPrivateKey = vm.envUint("MAINNET_KEY");
            owner = 0xB5a9e5a319c7fDa551a30BE592c77394bF935c6f;
        } else if (chainId == 5) {
            deployerPrivateKey = vm.envUint("TESTNET_KEY");
            owner = 0xF332533bF5d0aC462DC8511067A8122b4DcE2B57;
        } else if (chainId == 11155111) {
            deployerPrivateKey = vm.envUint("TESTNET_KEY");
            owner = 0xF332533bF5d0aC462DC8511067A8122b4DcE2B57;
        } else {
            revert ChainIdInvalid(chainId);
        }

        vm.startBroadcast(deployerPrivateKey);

        if (chainId == 1) {
            IMMUTABLE_CREATE2_FACTORY.safeCreate2({
                salt: vm.envBytes32("TRANSFER_MANAGER_SALT"),
                initializationCode: abi.encodePacked(type(TransferManager).creationCode, abi.encode(owner))
            });
        } else {
            new TransferManager(owner);
        }

        vm.stopBroadcast();
    }
}
