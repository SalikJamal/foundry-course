// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { Script } from 'forge-std/Script.sol';
import { MockV3Aggregator } from '../test/mocks/MockV3Aggregator.sol';

/**
 * 1. Deploy mocks when we are on a local anvil chain
 * 2. Keep track of contract addresses across different chains
 * 
 * It will work like:
 * If we are on a local anvil chain, we deploy the mock contract
 * Otherwise, grab the existing address from the live network 
 *
*/


contract HelperConfig is Script {

    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    uint8 public constant ETH_MAINNET_CHAINID = 1;
    uint32 public constant SEPOLIA_CHAINID = 11155111;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeed; // ETH/USD price feed address
    }

    constructor() {
        if(block.chainid == SEPOLIA_CHAINID) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if(block.chainid == ETH_MAINNET_CHAINID) {
            activeNetworkConfig = getMainnetEthConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns(NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({ priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306 });
        return sepoliaConfig;
    }

    function getMainnetEthConfig() public pure returns(NetworkConfig memory) {
        NetworkConfig memory mainnetConfig = NetworkConfig({ priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 });
        return mainnetConfig;
    }

    function getOrCreateAnvilEthConfig() public returns(NetworkConfig memory) {
        
        // If already deployed on local then return that instead of deploying new one
        if(activeNetworkConfig.priceFeed != address(0)) return activeNetworkConfig;

        // 1. Deploy the mocks on local network
        // 2. Return the mock address

        vm.startBroadcast();
            MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({ priceFeed: address(mockPriceFeed) });
        return anvilConfig;

    }

}
