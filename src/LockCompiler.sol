// SPDX-License-Identifier: MIT

// Bad - solc >= 0.8 and < 9
// pragma solidity ^0.8;

// Good
pragma solidity 0.8.13;

contract LockCompiler {}
// Why?
// Can't remember which version was deployed
// Slow to identify bugs in compiler
// Difficulty verifying contract on etherscan
// Recommendation
// use recent but not the latest version