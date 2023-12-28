// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// since we deploy AlienCodex directly from the artifacts, we need its interface
interface IAlienCodex {
    function owner() external view returns (address);

    function makeContact() external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;
}
