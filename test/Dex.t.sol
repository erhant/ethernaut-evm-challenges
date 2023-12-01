// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Dex, SwappableToken} from "~/Dex.sol";

contract DexTest is Test {
    Dex target;
    address player;
    SwappableToken private token1;
    SwappableToken private token2;

    function setUp() public {
        player = makeAddr("player");

        // create Dex & tokens
        target = new Dex();
        token1 = new SwappableToken(address(target), "Token 1", "TKN1", 110);
        token2 = new SwappableToken(address(target), "Token 2", "TKN2", 110);
        target.setTokens(address(token1), address(token2));

        // approve tokens to Dex
        token1.approve(address(target), 100);
        token2.approve(address(target), 100);

        // add liq to the pool
        target.addLiquidity(address(token1), 100);
        target.addLiquidity(address(token2), 100);

        // player starts with 10 of both tokens
        token1.transfer(player, 10);
        token2.transfer(player, 10);
    }

    function attack() private {
        // TODO: attack
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        uint256 balance1 = token1.balanceOf(address(this));
        uint256 balance2 = token2.balanceOf(address(this));
        assertTrue(balance1 == 0 || balance2 == 0, "either token1 or token2 must be drained");
    }
}
