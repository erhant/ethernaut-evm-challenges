// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Preservation, LibraryContract} from "ethernaut/levels/Preservation.sol";
import {Attacker} from "~/helpers/Preservation.sol";

contract PreservationTest is Test {
    Preservation target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        LibraryContract lib1 = new LibraryContract();
        LibraryContract lib2 = new LibraryContract();
        target = new Preservation(address(lib1), address(lib2));
    }

    function attack() private {
        Attacker attacker = new Attacker(address(target));
        attacker.attack();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(player, target.owner(), "player must be the owner");
    }
}
