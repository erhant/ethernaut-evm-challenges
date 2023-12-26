// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Elevator, Building} from "ethernaut/levels/Elevator.sol";
import {Attacker} from "~/helpers/Elevator.sol";

contract ElevatorTest is Test {
    Elevator target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new Elevator();
    }

    function attack() private {
        Attacker attacker = new Attacker(target);
        attacker.goTo(0); // any floor number should work
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertTrue(target.top(), "must have reached the top floor");
    }
}
