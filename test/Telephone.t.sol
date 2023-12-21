// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Telephone} from "ethernaut/levels/Telephone.sol";
import {Attacker} from "~/helpers/Telephone.sol";

contract TelephoneTest is Test {
    Telephone target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        target = new Telephone();
    }

    function attack() private {
        new Attacker(target);
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(target.owner(), player, "must be the owner");
    }
}
