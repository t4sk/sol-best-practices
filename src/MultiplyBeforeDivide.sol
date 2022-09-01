// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Why? - Avoid rounding errors

contract MultiplyBeforeDivide {
    // Return 90% of x
    function bad(uint x, uint y, uint z) external pure returns (uint) {
        // x * (90 / 100) always returns 0
        return x * (y / z);
    }

    function good(uint x, uint y, uint z) external pure returns (uint) {
        return (x * y) / z;
    }
}

// Another example
contract Pool {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    uint private constant MULTIPLIER = 1e18;

    constructor() {
        totalSupply = 1000 * 1e18;
        balanceOf[msg.sender] = 90 * 1e18;
    }

    function calculateSharesRatio(address account) external view returns (uint) {
        if (totalSupply > 0) {
            // Bad - always returns 0
            // return balanceOf[account] / totalSupply;

            // 100% = 1e18
            return (balanceOf[account] * MULTIPLIER) / totalSupply;
        }
        return 0;
    }
}