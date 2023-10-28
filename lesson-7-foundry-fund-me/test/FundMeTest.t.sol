// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Test, console } from 'forge-std/Test.sol';
import { FundMe } from '../src/FundMe.sol';
import { DeployFundMe } from '../script/DeployFundMe.s.sol';

contract FundMeTest is Test {

    FundMe fundMe;

    function setUp() external {
        // We deploy FundMeTest contract
        // FundMeTest contract deploys FundMe contract
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
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

}