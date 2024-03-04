// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script{

    uint256 public constant SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant POLYGON_MUMBAI = 80001;
    uint256 public constant ARBITRUM_NITRO_GOERLI = 421613;
    uint256 public constant AVALANCHE_FUJI = 43113;
    uint256 public constant OPTIMISM_GOERLI = 420;


    struct NetworkConfig{
        address daiAddress;
        address usdcAddress;
        address aave_pool_address_provider;
    }

    NetworkConfig public networkConfig;

    constructor(){
        if (block.chainid == SEPOLIA_CHAIN_ID){
            networkConfig = getSepoliaConfig();
        }
        if (block.chainid == POLYGON_MUMBAI){
            networkConfig = getPolygonMumbaiConfig();
        }
        if (block.chainid == ARBITRUM_NITRO_GOERLI){
            networkConfig = getArbitrumGoerliConfig();
        }
        if (block.chainid == AVALANCHE_FUJI){
            networkConfig = getAvalancheFujiConfig();
        }
        if (block.chainid == OPTIMISM_GOERLI){
            networkConfig = getOptimismGoerliConfig();
        }
    }

    function getSepoliaConfig() public pure returns(NetworkConfig memory){
        return NetworkConfig({
            daiAddress: 0xFF34B3d4Aee8ddCd6F9AFFFB6Fe49bD371b8a357,
            usdcAddress: 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8,
            aave_pool_address_provider: 0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A
        });
    }
    function getPolygonMumbaiConfig() public pure returns(NetworkConfig memory){
        return NetworkConfig({
            daiAddress: 0xc8c0Cf9436F4862a8F60Ce680Ca5a9f0f99b5ded,
            usdcAddress: 0x52D800ca262522580CeBAD275395ca6e7598C014,
            aave_pool_address_provider: 0x4CeDCB57Af02293231BAA9D39354D6BFDFD251e0
        });
    }
    function getArbitrumGoerliConfig() public pure returns(NetworkConfig memory){
        return NetworkConfig({
            daiAddress: 0xe73C6dA65337ef99dBBc014C7858973Eba40a10b,
            usdcAddress: 0xd513E4537510C75E24f941f159B7CAFA74E7B3B9,
            aave_pool_address_provider: 0xD64dDe119f11C88850FD596BE11CE398CC5893e6
        });
    }
    function getAvalancheFujiConfig() public pure returns(NetworkConfig memory){
        return NetworkConfig({
            daiAddress: 0x676bD5B5d0955925aeCe653C50426940c58036c8,
            usdcAddress: 0xCaC7Ffa82c0f43EBB0FC11FCd32123EcA46626cf,
            aave_pool_address_provider: 0xfb87056c0587923f15EB0aABc7d0572450Cc8003
        });
    }
    function getOptimismGoerliConfig() public pure returns(NetworkConfig memory){
        return NetworkConfig({
            daiAddress: 0xCD4e0d6D2b1252E2A709B8aE97DBA31164C5a709,
            usdcAddress: 0x69529987FA4A075D0C00B0128fa848dc9ebbE9CE,
            aave_pool_address_provider: 0xf3a4595bD9FBf129DEb80802a4785873F0ceB65c
        });
    }


}