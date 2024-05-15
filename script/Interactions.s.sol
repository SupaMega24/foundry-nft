//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant PUP =
        "ipfs://bafybeicz57su3zyafexgchnfqej7zuxfa3e4xgz22yzmge6nzkhfmskqs4/?filename=QmUPjADFGEKmfohdTaNcWhp7VGk26h5jXDA7v3VtTnTLcW";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUP);
        vm.stopBroadcast();
    }
}
