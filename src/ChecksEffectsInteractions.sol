// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Check - check input
// Effect - update state variables
// Interaction - Call other accounts / contracts

// Why? - Decrease the chance of writing a contract that is vulnerable to re-entrancy.

contract ChecksEffectsInteractions {
    mapping(address => uint) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    function withdrawBad(uint amount) external {
        payable(msg.sender).call{value: amount}("");
        balanceOf[msg.sender] -= amount;
    }

    function withdrawGood(uint amount) external {
        // Check
        require(amount > 0, "amount = 0");

        // Effect
        balanceOf[msg.sender] -= amount;

        // Interaction
        payable(msg.sender).call{value: amount}("");
    }
}