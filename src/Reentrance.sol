// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// NOTE: Original challenge used v6 with SafeMath. We have removed SafeMath
// and updated the version to v8.

contract Reentrance {
    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to] + msg.value;
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result,) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            // NOTE: added unchecked here to prevent underflow
            unchecked {
                balances[msg.sender] -= _amount;
            }
        }
    }

    receive() external payable {}
}
