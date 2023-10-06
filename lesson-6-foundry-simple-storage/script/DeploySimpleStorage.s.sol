// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { SimpleStorage } from  "../src/SimpleStorage.sol";

contract DeploySimpleStorage is Script {

    function run() external returns(SimpleStorage) {
        vm.startBroadcast();

        // This line will send a transaction to the RPC URL, and create a new contract instance.
        SimpleStorage simpleStorage = new SimpleStorage();

        vm.stopBroadcast();
    
        return simpleStorage;
    }
}