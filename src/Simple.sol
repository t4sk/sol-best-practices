// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Why? - Security

// Bad
contract ComplexContract {
    // Complex code

    // Calling many functions and contracts
    function callingManyFunctionsAndContracts() external {
        // Call A.foo()
        // func1();
        // func2();
        // Call B.bar()
        // func3();
        // Call C.baz()
        // ...
    }

    // Do many things
    function swapTokens() external {}
    function lend() external {}
    function borrow() external {}
    function liquidate() external {}

    // Having many view functions
    function getPrice() external view returns (uint) {}
    function getHistoricalPrice() external view returns (uint) {}
    function getAveragePrice() external view returns (uint) {}
}

// Good
contract SimpleContract {
    // Simple code
    // Do as little as possible - YAGNI - You aren't gonna need it
}

// Good - Splitting contracts - core and view
contract CoreContract {}

contract ViewContract {}

