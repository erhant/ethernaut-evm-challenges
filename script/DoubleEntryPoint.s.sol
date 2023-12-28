// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {DoubleEntryPoint} from "ethernaut/levels/DoubleEntryPoint.sol";
import {DetectionBot} from "~/helpers/DoubleEntryPoint.sol";

contract Check is CheckScript("DOUBLE_ENTRY_POINT") {}

contract Solve is SolveScript("DOUBLE_ENTRY_POINT") {
    DoubleEntryPoint target;

    constructor() {
        target = DoubleEntryPoint(instance);
    }

    function attack() public override {
        // register your detection bot to the target
        DetectionBot detectionBot = new DetectionBot(address(target.cryptoVault()));
        target.forta().setDetectionBot(address(detectionBot));
    }
}
