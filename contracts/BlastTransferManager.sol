// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {TransferManager} from "./TransferManager.sol";
import {IBlast, YieldMode, GasMode} from "./interfaces/IBlast.sol";

/**
 * @title BlastTransferManager
 * @notice This contract provides the transfer functions for ERC20/ERC721/ERC1155 for contracts on Blast that require them.
 * @author LooksRare protocol team (👀,💎)
 */
contract BlastTransferManager is TransferManager {
    /**
     * @notice Constructor
     * @param _owner Owner address
     * @param _blast Blast yield contract
     */
    constructor(address _owner, address _blast) TransferManager(_owner) {
        IBlast(_blast).configure(YieldMode.CLAIMABLE, GasMode.CLAIMABLE, _owner);
    }
}
