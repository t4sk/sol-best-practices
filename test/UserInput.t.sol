// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/UserInput.sol";

contract UserInputTest is Test {
    UserInput private target;
    MaliciousContract private mal;

    function setUp() public {
        target = new UserInput();
        mal = new MaliciousContract();
    }

    function testDeposit() public {
        target.deposit(address(mal), 123);
    }
}
