// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./IERC20.sol";

// Why? - User can execute a malicious contract inside your contract

contract UserInput {
    function deposit(address token, uint amount) external {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        // More code...
    }
    // Recommendation - whitelist user inputs if possible
}

contract MaliciousContract {
    event Log(string message);

    // forge test -vvvv
    function transferFrom(address from, address to, uint amount) external returns (bool) {
        // Malicious code here
        emit Log("hacked!!!");
        return true;
    }
}
