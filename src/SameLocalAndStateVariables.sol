// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract SameLocalAndStateVariables {
    uint256 public totalSupply;

    function bad() external {
        uint256 totaSupply = 123;

        //  More code here...

        // I want to update state variable
        // but local variable is updated
        totalSupply = 456; 
    }

    function good() external {
        uint256 _totalSupply = 123;

        //  More code here...

        totalSupply = 456;
    }

    // Bonus
    // Pure functions don't read state variables so there is no possibility
    // of mixing up local and state variables.
    function somePureFunc(uint256 x, uint256 y)
        external
        pure
        returns (uint256)
    {
        uint256 totalSupply = x + y;
        return totalSupply;
    }
}