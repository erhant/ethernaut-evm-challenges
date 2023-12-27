// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {MagicNum} from "ethernaut/levels/MagicNum.sol";

contract Check is CheckScript("MAGIC_NUM") {}

contract Solve is SolveScript("MAGIC_NUM") {
    MagicNum target;

    constructor() {
        target = MagicNum(instance);
    }

    function attack() public override {
        // deploy contract via CREATE
        bytes memory code = hex"600a600C600039600a6000F3602a60805260206080F3";
        address addr;
        assembly {
            addr := create(0, add(code, 0x20), mload(code))
            if iszero(extcodesize(addr)) { revert(0, 0) }
        }

        target.setSolver(addr);
    }
}
