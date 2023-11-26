// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

contract MoreEVMPuzzlesTest is Test {
    address puzzle;

    function setUp() public {
        puzzle = makeAddr("puzzle");
    }

    function testPuzzle01() public {
        bytes memory code =
            hex"36340A56FEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE5B58360156FEFE5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 2}(hex"112233445566");
        assertTrue(ok);
    }

    function testPuzzle02() public {
        bytes memory code = hex"3660006000373660006000F0600080808080945AF13D600a14601F57FEFEFE5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(hex"600a600c600039600a6000f3600a80f3");
        assertTrue(ok);
    }

    function testPuzzle03() public {
        bytes memory code = hex"3660006000373660006000F06000808080935AF460055460aa14601e57fe5b00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(hex"6005600c60003960056000f360aa600555"); // any 4-byte would work
        assertTrue(ok);
    }

    function testPuzzle04() public {
        bytes memory code = hex"30313660006000373660003031F0319004600214601857FD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 2 /* must be even */ }(hex"600080808060023404815af1600080f3");
        assertTrue(ok);
    }

    function testPuzzle05() public {
        bytes memory code = hex"60203611600857FD5B366000600037365903600314601957FD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(
            hex"11223344112233441122334411223344112233441122334411223344112233441122334411223344112233441122334411223344112233441122334411"
        );
        assertTrue(ok);
    }

    function testPuzzle06() public {
        bytes memory code =
            hex"7ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff03401600114602a57fd5b00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 0x0F + 2}("");
        assertTrue(ok);
    }

    function testPuzzle07() public {
        bytes memory code = hex"5a345b60019003806000146011576002565b5a90910360a614601d57fd5b00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 4}("");
        assertTrue(ok);
    }

    function testPuzzle08() public {
        bytes memory code =
            hex"341519600757fd5b3660006000373660006000f047600060006000600047865af1600114602857fd5b4714602f57fd5b00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(hex"600f600c600039600f6000f3600160805260016080808047335af1");
        assertTrue(ok);
    }

    function testPuzzle09() public {
        bytes memory code = hex"34600052602060002060F81C60A814601657FDFDFDFD5B00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call{value: 47}("");
        assertTrue(ok);
    }

    function testPuzzle10() public {
        bytes memory code =
            hex"602060006000376000517ff0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f01660206020600037600051177fabababababababababababababababababababababababababababababababab14605d57fd5b00";
        vm.etch(puzzle, code);
        (bool ok,) = puzzle.call(
            hex"A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A00B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B"
        );
        assertTrue(ok);
    }
}
