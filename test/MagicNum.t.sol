// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MagicNum} from "ethernaut/levels/MagicNum.sol";

contract MagicNumTest is Test {
    MagicNum target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        target = new MagicNum();
    }

    /*
     * // initialization code:
     * PUSH1 0x0a // 10 bytes
     * PUSH1 ;;;; // position in bytecode, we dont know yet
     * PUSH1 0x00 // write to memory position 0
     * CODECOPY   // copies the bytecode
     * PUSH1 0x0a // 10 bytes
     * PUSH1 0x00 // read from memory position 0
     * RETURN     // returns the code copied above
     *
     * // runtime code:
     * PUSH1 0x2A // our 1 byte value 42 = 0x2A
     * PUSH1 0x80 // memory position 0x80, the first free slot
     * MSTORE     // stores 0x2A at 0x80
     * PUSH1 0x20 // to return an uint256, we need 32 bytes (not 1)
     * PUSH1 0x80 // position to return the data
     * RETURN     // returns 32 bytes from 0x80
     *
     * // 0x600a600C600039600a6000F3602a60805260206080F3
     */
    function attack() private {
        // deploy contract via CREATE
        bytes memory code = hex"600a600C600039600a6000F3602a60805260206080F3";
        address addr;
        assembly {
            addr := create(0, add(code, 0x20), mload(code))
            if iszero(extcodesize(addr)) { revert(0, 0) }
        }

        target.setSolver(addr);
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        // get the solver of the player
        address solver = target.solver();

        // check contract size, must be less-than-or-equal to 10
        uint256 size;
        assembly {
            size := extcodesize(solver)
        }
        assertLe(size, 10, "contract size must be <= 10");

        // check the result
        uint256 result = Solver(solver).whatIsTheMeaningOfLife();
        assertEq(result, 42, "result is not 42");
    }
}

interface Solver {
    function whatIsTheMeaningOfLife() external view returns (uint256);
}
