// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperThree} from "ethernaut/levels/GatekeeperThree.sol";
import {Attacker} from "~/helpers/GatekeeperThree.sol";

contract GatekeeperThreeTest is Test {
    GatekeeperThree target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new GatekeeperThree();
    }

    function attack() private {
        Attacker attacker = new Attacker();
        attacker.enter{value: 0.001 ether + 1}(target);
    }

    function testAttack() public {
        vm.startPrank(player, player); // tx.origin is pranked as well
        attack();
        vm.stopPrank();

        assertEq(target.entrant(), player, "player must be the entrant");
    }
}
