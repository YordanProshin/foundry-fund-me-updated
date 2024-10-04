//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script,console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script 
{
    uint256 constant SEND_VALUE=0.01 ether;
    function fundFundMe(address mostRecentlyDeployed) public
    {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: 1e18}();
        vm.stopBroadcast();
    }

    function run() external
    {
        address mostRecentlyDeployed=DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
        fundFundMe(mostRecentlyDeployed);
    }
}

contract WithdrawFundMe is Script
{
    function withdrawFundMe(address mostRecentlyDeployed) public
    {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external
    {
        address mostRecentlyDeployed=DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
        withdrawFundMe(mostRecentlyDeployed);
    }
}