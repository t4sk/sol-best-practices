// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Why? - There is a limit on the amount of gas that can be used in a block.
// Unbounded loops may consume more gas than the block gas limit.

contract Loop {
    address[] public accounts;
    mapping(address => uint) public balances;

    function join() external {
        accounts.push(msg.sender);
    }

    function bad() external {
        // Increment all accounts' balance
        for (uint i; i < accounts.length; i++) {
            balances[accounts[i]] += 1;
        }
    }

    function good(uint start, uint end) external {
        // Increment all accounts' balance
        for (uint i = start; i < end; i++) {
            balances[accounts[i]] += 10;
        }
    }
}
