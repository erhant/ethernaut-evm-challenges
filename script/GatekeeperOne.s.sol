// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {GatekeeperOne} from "ethernaut/levels/GatekeeperOne.sol";
import {Attacker} from "~/helpers/GatekeeperOne.sol";

contract Check is CheckScript("GATEKEEPER_ONE") {}

contract Solve is SolveScript("GATEKEEPER_ONE") {
    GatekeeperOne target;

    constructor() {
        target = GatekeeperOne(instance);
    }

    function attack() public override {
        // TODO: todo
    }
}
