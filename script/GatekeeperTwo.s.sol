// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {GatekeeperTwo} from "ethernaut/levels/GatekeeperTwo.sol";
import {Attacker} from "~/helpers/GatekeeperTwo.sol";

contract Check is CheckScript("GATEKEEPER_TWO") {}

contract Solve is SolveScript("GATEKEEPER_TWO") {
    GatekeeperTwo target;

    constructor() {
        target = GatekeeperTwo(instance);
    }

    function attack() public override {
        new Attacker(target);
    }
}
