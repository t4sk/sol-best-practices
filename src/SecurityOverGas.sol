// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract SecurityOverGas {
    // Sum nums - save gas
    function bad(uint[] calldata nums) external pure returns (uint total) {
        uint len = nums.length;

        for (uint i = 0; i < len;) {
            total += nums[i];
            unchecked {
                ++i;
            }
        }
    }

    // Prioritize code readability + security > gas cost
    function good(uint[] calldata nums) external pure returns (uint total) {
        uint len = nums.length;

        for (uint i = 0; i < len; ++i) {
            total += nums[i];
        }
    }
}