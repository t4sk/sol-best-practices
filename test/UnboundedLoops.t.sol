// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/UnboundedLoops.sol";

// forge test --match-path test/UnboundedLoops.t.sol
contract UnboundedLoopsTest is Test {
    UnboundedLoops private loops;

    function setUp() public {
       loops = new UnboundedLoops(); 
    }

    function testGas1() public {
        for (uint i; i < 3; ++i) {
            loops.join();
        }
        loops.test();
    }

    function testGas2() public {
        for (uint i; i < 10; ++i) {
            loops.join();
        }
        loops.test();
    }
}
