// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Ethernaut} from "ethernaut/Ethernaut.sol";
import {Level} from "ethernaut/levels/base/Level.sol";

contract SolveScript is Script {
    Ethernaut ethernaut = Ethernaut(vm.envAddress("ADDR_ETHERNAUT"));
    address payable instance;
    address level;
    address player;

    constructor(string memory name) {
        instance = payable(vm.envAddress(string.concat("INST_", name)));
        level = vm.envAddress(string.concat("LVL_", name));
    }

    function setUp() public {
        player = msg.sender;
    }

    function run() public {
        vm.startBroadcast();
        attack();
        vm.stopBroadcast();

        verify();
    }

    function verify() private {
        require(Level(level).validateInstance(instance, player), "Instance validation failed!");
    }

    function attack() public virtual {}
}
