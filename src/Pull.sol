// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

// Push - send ETH or token to some address
// Pull - allow caller to withdraw ETH or token

// Why? - Re-entrancy and accidentally send to wrong address

// Bad
contract Push {
    function sendEth(address payable to, uint256 amount) external {
        (bool ok,) = to.call{value: amount}("");
        require(ok, "transfer failed");
    }

    function sendEthMany(address[] calldata receivers, uint256 amount)
        external
    {
        for (uint256 i; i < receivers.length; ++i) {
            (bool ok,) = receivers[i].call{value: amount}("");
            require(ok, "transfer failed");
        }
    }

    function sendToken(address token, address to, uint256 amount) external {
        IERC20(token).transfer(to, amount);
    }
}

// Good
contract Pull {
    mapping(address => uint256) public ethBalances;
    mapping(address => mapping(address => uint256)) public tokenBalances;

    function giveEth(address to, uint256 amount) external {
        ethBalances[to] += amount;
    }

    function withdrawEth(uint256 amount) external {
        ethBalances[msg.sender] -= amount;
        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "transfer failed");
    }

    function giveToken(address token, address to, uint256 amount) external {
        tokenBalances[token][to] += amount;
    }

    function withdrawToken(address token, uint256 amount) external {
        tokenBalances[token][msg.sender] -= amount;
        IERC20(token).transfer(msg.sender, amount);
    }
}