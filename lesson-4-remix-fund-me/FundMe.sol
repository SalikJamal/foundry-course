// Get funds from users into this contract
// Withdraw funds to the owner of this contract
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;


contract FundMe {

    uint256 public minimumUsd = 5;

    function fund() public payable {
        // Allow users to send $
        // Have a minimum $5 sent
        require(msg.value >= minimumUsd, "Didn't sent enough ETH"); // 1e18 = 1 ETH
    }

    // function withdraw() public {}

}