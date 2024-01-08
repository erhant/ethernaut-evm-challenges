// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CoinFlip} from "ethernaut/levels/CoinFlip.sol";
import {Attacker} from "~/helpers/CoinFlip.sol";

contract CoinFlipTest is Test {
    CoinFlip target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        // starting at the first block causes an error
        vm.roll(block.number + 1);
        target = new CoinFlip();
    }

    function attack() private {
        Attacker attacker = new Attacker(address(target));

        // we start the attack at some block
        uint256 startingBlock = block.number;
        console.log(block.number);

        for (uint256 i = 0; i <= 10; i++) {
            // we will attack once for each block,
            // so we use `vm.roll` to simulate mining a new block
            vm.roll(startingBlock + i);
            console.log(block.number);

            bool result = attacker.psychicFlip();
            require(result, "failed psychic flip");
        }
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertTrue(target.consecutiveWins() >= 10, "must have at least 10 consecutive wins");
    }
}
