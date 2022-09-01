// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

// Why? - Re-entrancy and accidentally send to wrong address

// Bad
contract Push {
    function sendEth(address payable to, uint amount) external {
        to.call{value: amount}();
    }

    function sendToken(address token, address to, uint amount) external {
        IERC20(token).transfer(to, amount);
    }
}

// Good
contract Pull {
    mapping(address => uint) public ethBalances;
    mapping(address => mapping(address => uint)) public tokenBalances;

    function giveEth(address to, uint amount) external {
        ethBalances[to] += amount;
    }

    function withdrawEth(uint amount) external {
        ethBalances[msg.sender] -= amount; 
        msg.sender.call{value: amount}("");
    }

    function giveToken(address token, address to, uint amount) external {
        tokenBalances[token][to] += amount;
    }

    function withdrawToken(address token, uint amount) external {
        tokenBalances[token][msg.sender] -= amount; 
        IERC20(token).transfer(msg.sender, amount);
    }
}
