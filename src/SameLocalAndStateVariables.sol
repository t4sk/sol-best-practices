// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract SameLocalAndStateVariables {
    uint public totalSupply; 
    
    function bad() external {
        uint totaSupply = 123;

        //  More code here...

        // I want to update state variable
        // but local variable is updated
        totalSupply = 456;

        // Also no compiler warning
    }

    function good() external {
        uint _totalSupply = 123;

        //  More code here...

        totalSupply = 456;
    }

    // Bonus
    // Pure functions don't read state variables so there is no possibility
    // of mixing up local and state variables.
    function somePureFunc(uint x, uint y) external pure returns (uint) {
        uint totalSupply = x + y;
        return totalSupply;
    }
}