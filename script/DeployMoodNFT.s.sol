// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT) {
        // To automatically read files from dev arena,
        //Use foundry cheatcode readFiles
        // Set in fouundry.toml "fs_permissions = [{access = "read", path = "./images/"}]"

        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(
            convertSvgToImageURI(sadSvg),
            convertSvgToImageURI(happySvg)
        );
        // svgToImageURI(svg) converts svg files to its token URI format
        // MoodNFT constructor needs the tokenURI of NFTs
        vm.stopBroadcast();
        return moodNFT;
    }

    function convertSvgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURLPrefix = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURLPrefix, svgBase64Encoded));
    }
}
