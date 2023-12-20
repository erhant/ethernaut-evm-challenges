// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

contract Puzzle is Test {
    address private addr;

    function setUp() public {
        addr = makeAddr("puzzle");
    }

    /**
     * Sets the code of address to the given puzzle,
     * and solves it with the given value and calldata.
     */
    function puzzle(bytes memory _code, uint256 _value, bytes memory _data) public {
        vm.etch(addr, _code);

        (bool ok,) = addr.call{value: _value}(_data);

        assertTrue(ok, "puzzle failed");
    }
}
