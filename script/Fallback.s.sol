// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

contract FallbackScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        // TODO: todo
    }
}
