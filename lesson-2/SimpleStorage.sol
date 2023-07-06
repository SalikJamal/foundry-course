// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;


contract SimpleStorage {

    uint256 myFavoriteNumber; // 0
    
    // uint256[] listOfFavoriteNumbers;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople; // []

    function store(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }

    // View function
    function retrieve() public view returns(uint256) {
        return myFavoriteNumber;
    }

    function addPerson(uint256 _favoriteNumber, string memory _name) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
    }

}