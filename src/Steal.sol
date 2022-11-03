// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Steal{
    address private owner;

    constructor() payable {
        require(msg.value == 10 ether);
        owner = msg.sender;
    }

    function steal(address delefate, bytes memory args) external {
        (bool sent, ) = delefate.delegatecall(args);
        require(sent, "call failed");
        require(address(this).balance == 10 ether, "you can't steal my ether");
    }

    function withdraw() external {
        require(msg.sender == owner, "only owner");
        payable(msg.sender).transfer(address(this).balance);
    }
}
