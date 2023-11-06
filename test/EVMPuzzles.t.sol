// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract EVMPuzzlesTest is Test {
    address puzzle;

    function setUp() public {
        puzzle = makeAddr("puzzle");
    }

    function testPuzzle01() public {
        bytes memory code = hex"3456FDFDFDFDFDFD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 8}("");
        assertTrue(ok);
    }

    function testPuzzle02() public {
        bytes memory code = hex"34380356FDFD5B00FDFD";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 4}("");
        assertTrue(ok);
    }

    function testPuzzle03() public {
        bytes memory code = hex"3656FDFD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(hex"11223344"); // any 4-byte would work
        assertTrue(ok);
    }

    function testPuzzle04() public {
        bytes memory code = hex"34381856FDFDFDFDFDFD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 6}("");
        assertTrue(ok);
    }

    function testPuzzle05() public {
        bytes memory code = hex"34800261010014600C57FDFD5B00FDFD";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 16}("");
        assertTrue(ok);
    }

    function testPuzzle06() public {
        bytes memory code = hex"60003556FDFDFDFDFDFD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(abi.encode(0x0A)); // 0x0A zero-padded
        assertTrue(ok);
    }

    function testPuzzle07() public {
        bytes memory code = hex"36600080373660006000F03B600114601357FD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(hex"6001600C60003960016000F3EE");
        assertTrue(ok);
    }

    function testPuzzle08() public {
        bytes memory code = hex"36600080373660006000F0600080808080945AF1600014601B57FD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(hex"6005600C60003960056000F360006000FD");
        assertTrue(ok);
    }

    function testPuzzle09() public {
        bytes memory code = hex"36600310600957FDFD5B343602600814601457FD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 2}(hex"11223344");
        assertTrue(ok);
    }

    function testPuzzle10() public {
        bytes memory code = hex"38349011600857FD5B3661000390061534600A0157FDFDFDFD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 15}("");
        assertTrue(ok);
    }
}
