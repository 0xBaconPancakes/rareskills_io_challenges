// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract StealV2 {
    constructor() payable {
        require(msg.value == 10 ether);
    }

    function steal(address delefate, bytes memory args) external {
        (bool sent, ) = delefate.delegatecall(args);
        require(sent, "call failed");
        require(address(this).balance == 10 ether, "you can't steal my ether");
    }
}
