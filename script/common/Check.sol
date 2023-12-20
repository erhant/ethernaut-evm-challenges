// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Ethernaut} from "ethernaut/Ethernaut.sol";

/**
 * @title Check Script
 * @author erhant
 * @notice This contract will check if a given instance is solved or not.
 * - If it is solved, it will print the player name.
 */
contract CheckScript is Script {
    Ethernaut ethernaut = Ethernaut(vm.envAddress("ETHERNAUT"));
    address payable instance;

    constructor(string memory name) {
        instance = payable(vm.envAddress(string.concat("INST_", name)));
    }

    function run() public view {
        (address player,, bool ok) = ethernaut.emittedInstances(instance);
        if (ok) {
            console2.log("Solved by", player);
        } else {
            console2.log("This challenge is not solved yet!");
        }
    }
}
