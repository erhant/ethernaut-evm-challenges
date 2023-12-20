// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Instance} from "ethernaut/levels/Instance.sol";

contract Check is CheckScript("HELLOETHERNAUT") {}

contract Solve is SolveScript("HELLOETHERNAUT") {
    Instance target;

    constructor() {
        target = Instance(instance);
    }

    function attack() public override {
        target.authenticate(target.password());
    }
}
