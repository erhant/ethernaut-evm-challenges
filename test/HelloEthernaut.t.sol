// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Instance} from "ethernaut/levels/Instance.sol";

contract HelloEthernautTest is Test {
    Instance target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        target = new Instance("ethernaut0");
    }

    function attack() private {
        target.authenticate(target.password());
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertTrue(target.getCleared(), "must be cleared");
    }
}
