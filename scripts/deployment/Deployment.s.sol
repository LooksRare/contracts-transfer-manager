// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Scripting tool
import {Script} from "../../lib/forge-std/src/Script.sol";

// Core contracts
import {TransferManager} from "../../contracts/TransferManager.sol";
import {BlastTransferManager} from "../../contracts/BlastTransferManager.sol";

// Create2 factory interface
import {IImmutableCreate2Factory} from "../../contracts/interfaces/IImmutableCreate2Factory.sol";

import {console2} from "forge-std/console2.sol";

/**
 * @dev
 * Use
 * forge create --rpc-url $SEPOLIA_RPC_URL \
 *     --private-key $TESTNET_KEY \
 *     --constructor-args 0xF332533bF5d0aC462DC8511067A8122b4DcE2B57 \
 *     --etherscan-api-key $ETHERSCAN_API_KEY \
 *     --verify contracts/TransferManager.sol:TransferManager

 * for testnet deployment
 */
contract Deployment is Script {
    IImmutableCreate2Factory private constant IMMUTABLE_CREATE2_FACTORY =
        IImmutableCreate2Factory(0x0000000000FFe8B47B3e2130213B802212439497);

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("BLAST_MAINNET_KEY");
        address owner = 0x2C64e6Ee1Dd9Fc2a0Db6a6B1aa2c3f163C7A2C78;
        address blast = 0x4300000000000000000000000000000000000002;

        vm.startBroadcast(deployerPrivateKey);

        IMMUTABLE_CREATE2_FACTORY.findCreate2Address(
            vm.envBytes32("BLAST_TRANSFER_MANAGER_SALT"),
            abi.encodePacked(type(BlastTransferManager).creationCode, abi.encode(owner, blast))
        );

        vm.stopBroadcast();
    }
}
