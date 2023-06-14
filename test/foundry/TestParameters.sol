// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";

abstract contract TestParameters is Test {
    // Addresses
    address internal constant _owner = address(42);
    address internal constant _sender = address(88);
    address internal constant _recipient = address(90);
    address internal constant _transferrer = address(100);
}
