// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import {Script} from "forge-std/Script.sol";
import {FlashLoan} from "../src/FlashLoan.sol";
import {HelperConfig} from "./HelperConfig.sol";
import {Dex} from "../src/DEX.sol";

contract DeployFlashLoan is Script {
    FlashLoan public flashLoan;
    Dex public dex;

    HelperConfig public config;

    address public daiAddress;
    address public usdcAddress;
    address public aave_pool_address_provider;

    function run() external returns (FlashLoan, Dex) {
        config = new HelperConfig();
        (daiAddress, usdcAddress, aave_pool_address_provider) = config.networkConfig();
        
        vm.startBroadcast();
        dex = new Dex(daiAddress, usdcAddress);
        flashLoan = new FlashLoan(aave_pool_address_provider, daiAddress, usdcAddress, address(dex));
        vm.stopBroadcast();

        return (flashLoan, dex);
    }
}
