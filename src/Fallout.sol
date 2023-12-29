// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// NOTE: Removed SafeMath usage due as we are using a later
// compiler version that does checked artihmetic by default.
//
// As a result `allocate` function uses + instead of `.add` of SafeMath.
//
// Also note that up to solc v0.4.21, constructor can also be defined by name of the contract.
// People use `constructor` as the constructor itself, but this challenge is more
// about that older way of writing the constructor.

contract Fallout {
    mapping(address => uint256) allocations;
    address payable public owner;

    /* constructor */
    function Fal1out() public payable {
        owner = payable(msg.sender); // Type issues must be payable address
        allocations[owner] = msg.value;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function allocate() public payable {
        allocations[msg.sender] = allocations[msg.sender] + msg.value;
    }

    function sendAllocation(address payable allocator) public {
        require(allocations[allocator] > 0);
        allocator.transfer(allocations[allocator]);
    }

    function collectAllocations() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance); // Type issues must be payable address
    }

    function allocatorBalance(address allocator) public view returns (uint256) {
        return allocations[allocator];
    }
}
