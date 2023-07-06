// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;


contract SimpleStorage {

    uint256 myFavoriteNumber;
    
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }

    // View function
    function retrieve() public view returns(uint256) {
        return myFavoriteNumber;
    }

    // Calldata, memory, storage
    function addPerson(uint256 _favoriteNumber, string calldata _name) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}