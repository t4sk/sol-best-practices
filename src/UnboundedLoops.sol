// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Unbounded loops - No upper limit to number of loops

// Why? - There is a limit on the amount of gas that can be used in a block.
// Unbounded loops may consume more gas than the block gas limit.

contract UnboundedLoops {
    address[] public accounts;
    mapping(address => uint256) public balances;

    function join() external {
        accounts.push(msg.sender);
    }

    function bad() external {
        // Increment all accounts' balance
        for (uint256 i; i < accounts.length; i++) {
            balances[accounts[i]] += 1;
        }
    }

    function good(uint256 start, uint256 end) external {
        // Increment all accounts' balance
        for (uint256 i = start; i < end; i++) {
            balances[accounts[i]] += 10;
        }
    }

    function test() external {
        // Subtle unbounded loop
        test2(accounts);
    }

    function test2(address[] memory) public {
        // More code here
    }
}