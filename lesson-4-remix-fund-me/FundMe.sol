// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract FundMe {

    uint256 public minimumUsd = 5;

    function fund() public payable {
        // Allow users to send $
        // Have a minimum $5 sent
        require(msg.value >= minimumUsd, "Didn't sent enough ETH"); // 1e18 = 1 ETH
    }

    // function withdraw() public {}

    function getPrice() public view returns(uint256)  {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        // 2000.00000000 Example value
        return uint256(price * 1e10);
    }

    function getConversionRate() public {}

    function getVersion() public view returns(uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}

// Get funds from users into this contract
// Withdraw funds to the owner of this contract
// Set a minimum funding value in USD