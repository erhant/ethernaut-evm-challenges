// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Puzzle} from "./common/Puzzle.sol";

contract EVMPuzzlesTest is Puzzle {
    function testPuzzle01() public {
        puzzle(hex"3456FDFDFDFDFDFD5B00", 8, "");
    }

    function testPuzzle02() public {
        puzzle(hex"34380356FDFD5B00FDFD", 4, "");
    }

    function testPuzzle03() public {
        // any 4-byte calldata would work
        puzzle(hex"3656FDFD5B00", 0, hex"11223344");
    }

    function testPuzzle04() public {
        puzzle(hex"34381856FDFDFDFDFDFD5B00", 6, "");
    }

    function testPuzzle05() public {
        puzzle(hex"34800261010014600C57FDFD5B00FDFD", 16, "");
    }

    function testPuzzle06() public {
        // calldata is "0x0A" zero-padded
        puzzle(hex"60003556FDFDFDFDFDFD5B00", 0, abi.encode(0x0A));
    }

    function testPuzzle07() public {
        puzzle(hex"36600080373660006000F03B600114601357FD5B00", 0, hex"6001600C60003960016000F3EE");
    }

    function testPuzzle08() public {
        puzzle(
            hex"36600080373660006000F0600080808080945AF1600014601B57FD5B00", 0, hex"6005600C60003960056000F360006000FD"
        );
    }

    function testPuzzle09() public {
        puzzle(hex"36600310600957FDFD5B343602600814601457FD5B00", 2, hex"11223344");
    }

    function testPuzzle10() public {
        puzzle(hex"38349011600857FD5B3661000390061534600A0157FDFDFDFD5B00", 15, "");
    }
}
