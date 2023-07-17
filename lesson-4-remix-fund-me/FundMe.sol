// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { PriceConverter } from "./PriceConverter.sol";


contract FundMe {

    using PriceConverter for uint256;
    
    uint256 public minimumUsd = 5e18;
    
    address[] public funders;
    address public owner;

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not the owner!");
        _;
    }

    function fund() public payable onlyOwner {
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't sent enough ETH"); // 1e18 = 1 ETH
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        require(msg.sender == owner, "Must be owner");

        for(uint funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0); // A brand new array with data type address with value to be 0 addresses
        (bool callSuccess, ) = payable(msg.sender).call{ value: address(this).balance }("");
        require(callSuccess, "Call Failed");

    }
 
}

// Get funds from users into this contract
// Withdraw funds to the owner of this contract
// Set a minimum funding value in USD