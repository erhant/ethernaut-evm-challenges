// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console2} from "forge-std/Script.sol";
import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {CoinFlip} from "ethernaut/levels/CoinFlip.sol";
import {Attacker} from "~/helpers/CoinFlip.sol";

contract Check is CheckScript("COINFLIP") {}

contract Solve is SolveScript("COINFLIP") {
    CoinFlip target;

    constructor() {
        target = CoinFlip(instance);
    }

    // run script with option -s="deploy()"
    function deploy() public {
        vm.startBroadcast();
        Attacker attacker = new Attacker(address(target));
        vm.stopBroadcast();

        console2.log("Attacker deployed at:", address(attacker));
    }

    // run script with option -s="flip()"
    function flip() public {
        vm.startBroadcast();
        Attacker attacker = Attacker(vm.envAddress("ATKR_COINFLIP"));
        bool result = attacker.psychicFlip();
        require(result, "failed psychic flip");
        vm.stopBroadcast();
    }

    // finally run the script as usual to submit instance
    function attack() public override {
        // do nothing here, so it just submits the level
    }
}
