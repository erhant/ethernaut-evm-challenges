// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GoodSamaritan} from "ethernaut/levels/GoodSamaritan.sol";
import {Attacker} from "~/helpers/GoodSamaritan.sol";

contract GoodSamaritanTest is Test {
    GoodSamaritan target;
    address player;

    function setUp() public {
        player = makeAddr("player");

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
