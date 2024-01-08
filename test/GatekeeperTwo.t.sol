// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperTwo} from "ethernaut/levels/GatekeeperTwo.sol";
import {Attacker} from "~/helpers/GatekeeperTwo.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        target = new GatekeeperTwo();
    }

    function attack() private {
        new Attacker(target);
    }

    function testAttack() public {
        vm.startPrank(player, player); // tx.origin is pranked as well
        attack();
        vm.stopPrank();

        assertEq(target.entrant(), player, "player must be the entrant");
    }
}
