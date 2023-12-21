// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Reentrance} from "~/Reentrance.sol";
import {Attacker} from "~/helpers/Reentrance.sol";

contract ReentranceTest is Test {
    Reentrance target;
    address player;
    Attacker attacker;

    uint256 contractBalance = 1.05 ether;
    uint256 playerBalance = 0.2 ether;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, playerBalance);

        // contract has some donations by the owner at first
        target = new Reentrance();
        target.donate{value: contractBalance}(address(this));
    }

    function attack() private {
        attacker = new Attacker(payable(target));
        attacker.attack{value: playerBalance}();
        attacker.reap();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(address(target).balance, 0, "target must be drained");
        assertGt(player.balance, contractBalance, "player must have stolen the balance");
    }

    receive() external payable {}
}
