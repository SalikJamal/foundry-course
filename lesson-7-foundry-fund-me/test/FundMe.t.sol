// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Test, console } from 'forge-std/Test.sol';
import { FundMe } from '../src/FundMe.sol';


contract FundMeTest is Test {

    FundMe fundMe;

    function setUp() external {
        // We deploy FundMeTest contract
        // FundMeTest contract deploys FundMe contract
        fundMe = new FundMe();
    }

    function testMinDollarIsFive() public {
        assertEq(fundMe.MIN_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(), address(this));
    }

}