// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Privacy} from "~/Privacy.sol";

contract PrivacyTest is Test {
    Privacy target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        bytes32[3] memory data = [keccak256("super"), keccak256("duper"), keccak256("secret")];
        target = new Privacy(data);
    }

    function attack() private {
        // we can either look at the constructor args from etherscan to solve this,
        // or, we can read the storage using a tool like evm.storage or something
        //
        // foundry provides a method to do this via `vm.load`
        // so we use that instead
        bytes16 key = bytes16(vm.load(address(target), bytes32(uint256(5))));
        target.unlock(key);
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertFalse(target.locked(), "must have unlocked the contract");
    }
}
