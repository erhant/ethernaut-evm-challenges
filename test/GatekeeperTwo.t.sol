// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperOne} from "~/GatekeeperOne.sol";

contract GatekeeperOneTest is Test {
    GatekeeperOne target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new GatekeeperOne();
    }

    function attack() private {
        // TODO: attack
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(target.entrant(), player, "player must be the entrant");
    }
}

contract Attacker {
    address owner;

    constructor() {}
}
