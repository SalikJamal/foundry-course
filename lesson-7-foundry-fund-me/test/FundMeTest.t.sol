// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Test, console } from 'forge-std/Test.sol';
import { FundMe } from '../src/FundMe.sol';
import { DeployFundMe } from '../script/DeployFundMe.s.sol';

contract FundMeTest is Test {

    FundMe fundMe;

    address USER = makeAddr("user");

    uint256 constant SEND_VALUE = 0.1 ether; // 100000000000000000
    uint256 constant STARTING_BALANCE = 10 ether; // 10000000000000000000

    function setUp() external {
        // We deploy FundMeTest contract
        // FundMeTest contract deploys FundMe contract
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinDollarIsFive() public {
        assertEq(fundMe.MIN_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 ver = fundMe.getVersion();
        assertEq(ver, 4);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert();
        fundMe.fund(); // Send 0 value
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER); // The next Tx will be sent by USER
        fundMe.fund{ value: SEND_VALUE }();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

}