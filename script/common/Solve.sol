// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Ethernaut} from "ethernaut/Ethernaut.sol";
import {Level} from "ethernaut/levels/base/Level.sol";

/**
 * @title Solve Script
 * @author erhant
 * @notice A script that solves & broadcasts the solution for an Ethernaut challenge.
 * The user must override the virtual `attack` function to implement their attack, then:
 * - This contract will run the attack
 * - Verify that instance is solved
 * - Submit the instance
 */
contract SolveScript is Script {
    Ethernaut ethernaut = Ethernaut(vm.envAddress("ETHERNAUT"));
    address payable instance;
    address level;
    address player;

    constructor(string memory name) {
        instance = payable(vm.envAddress(string.concat("INST_", name)));
        level = vm.envAddress(string.concat("LVL_", name));
    }

    function setUp() public {
        // it is important that player address is assigned here, not in the constructor!
        player = msg.sender;
    }

    function run() public {
        vm.startBroadcast();
        attack();
        verify();
        submit();
        vm.stopBroadcast();
    }

    function verify() private {
        require(Level(level).validateInstance(instance, player), "Instance validation failed!");
    }

    function submit() private {
        ethernaut.submitLevelInstance(instance);
    }

    /// @dev we expect the user to write the attack in this function
    function attack() public virtual {}
}
