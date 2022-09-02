// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./IERC20.sol";

// Why? - User can execute a malicious contract inside your contract

contract UserInput {
    // Recommendation - whitelist user inputs if possible
    function deposit(address token, uint256 amount) external {
        IERC20(token).transferFrom(msg.sender, address(this), amount); // More code...
    }
}

contract MaliciousContract {
    event Log(string message);

    // forge test -vvvv --match-path test/UserInput.t.sol
    function transferFrom(address, address, uint256)
        external
        returns (bool)
    {
        // Malicious code here
        emit Log("hacked!!!");
        return true;
    }
}