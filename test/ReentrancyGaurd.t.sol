// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ReentrancyGuard.sol";

contract ReentrancyGuardTest is Test {
    Bank private target;
    Hack private hack;

    function setUp() public {
        target = new Bank();
        hack = new Hack(address(target));
    }

    function testNoLock() public {
        target.deposit{value: 1e18}();

        hack.pwn{value: 1e18}();
        assertEq(address(hack).balance, 2 * 1e18);
    }
}
