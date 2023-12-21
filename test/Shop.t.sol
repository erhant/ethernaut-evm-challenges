// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Shop, Buyer} from "ethernaut/levels/Shop.sol";
import {Attacker} from "~/helpers/Shop.sol";

contract ShopTest is Test {
    Shop target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        target = new Shop();
    }

    function attack() private {
        Attacker attacker = new Attacker(target);
        attacker.pwn();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertTrue(target.isSold(), "item must be sold");
        assertLt(target.price(), 100, "price must be less than 100");
    }
}
