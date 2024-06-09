//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "src/BasicNFT.sol";
import {Script} from "forge-std/Script.sol";

contract MintBasicNFT is Script {

    string public constant PUG_URI =
        "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address NFTContractAddress) public {
        vm.startBroadcast();
        BasicNFT(NFTContractAddress).mint(PUG_URI);
        vm.stopBroadcast();
    }
}
