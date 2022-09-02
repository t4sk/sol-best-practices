// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Checks - check inputs
// Effects - update state variables
// Interactions - Call other accounts / contracts

// Why? - Decrease the chance of writing a contract that is
// vulnerable to re-entrancy.

contract ChecksEffectsInteractions {
    mapping(address => uint256) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    function withdrawBad(uint256 amount) external {
        (bool ok,) = payable(msg.sender).call{value: amount}("");
        require(ok, "transfer failed");
        balanceOf[msg.sender] -= amount;
    }

    function withdrawGood(uint256 amount) external {
        // Check
        require(amount > 0, "amount = 0");

        // Effect
        balanceOf[msg.sender] -= amount;

        // Interaction
        (bool ok,) = payable(msg.sender).call{value: amount}("");
        require(ok, "transfer failed");
    }
}