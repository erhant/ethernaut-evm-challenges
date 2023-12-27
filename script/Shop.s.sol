// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Shop} from "ethernaut/levels/Shop.sol";
import {Attacker} from "~/helpers/Shop.sol";

contract Check is CheckScript("SHOP") {}

contract Solve is SolveScript("SHOP") {
    Shop target;

    constructor() {
        target = Shop(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker(target);
        attacker.pwn();
    }
}
