// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/Steal.sol";
import "./StealAttack.sol";

contract StealTest is Test {
    Steal public steal;

    function setUp() public {
        steal = new Steal{value: 10 ether}();
    }

    function testSteal() public {
        address attacker = address(0x1234567890123456789012345678901234567890);
        uint256 booty = 10 ether;
        vm.startPrank(attacker);

        assertEq(address(steal).balance, booty);

        StealAttack stealAttack = new StealAttack(); 
        stealAttack.attack(address(steal));

        assertEq(address(steal).balance, 0 ether, "contract not drained");
        assertEq(address(stealAttack).balance, booty, "did not receive ether");
    }
}
