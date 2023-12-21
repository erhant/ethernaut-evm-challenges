// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperOne} from "ethernaut/levels/GatekeeperOne.sol";
import {Attacker} from "~/helpers/GatekeeperOne.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);
        target = new GatekeeperOne();
    }

    function attack() private {
        new Attacker(target);
    }

    function testAttack() public {
        vm.startPrank(player, player);
        attack();
        vm.stopPrank();

        assertEq(target.entrant(), player, "player must be the entrant");
    }
}
