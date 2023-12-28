// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Preservation} from "ethernaut/levels/Preservation.sol";
import {Attacker} from "~/helpers/Preservation.sol";

contract Check is CheckScript("PRESERVATION") {}

contract Solve is SolveScript("PRESERVATION") {
    Preservation target;

    constructor() {
        target = Preservation(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker(address(target));
        attacker.attack();
    }
}
