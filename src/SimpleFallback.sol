// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

// Why? - Code may fail on simple sends of ETH (transfer)

// Bad
contract ComplexFallback {
    fallback() external payable { // Do many things here
            // Complex code
    }
}

// Good
contract SimpleFallback {
    fallback() external payable { // Simple code, for example - only log
    }
}