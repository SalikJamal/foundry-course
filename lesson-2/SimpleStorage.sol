// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;


contract SimpleStorage {

    uint256 public favoriteNumber; 

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // View function
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
    
    // Pure function
    function pureFunction() public pure returns(uint256) {
        return 5 + 5;
    }

}