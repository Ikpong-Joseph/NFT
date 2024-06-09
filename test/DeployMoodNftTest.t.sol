// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFT} from "script/DeployMoodNFT.s.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";


contract DeployMoodNFTTest is Test {
    DeployMoodNFT public deployer;

    function setUp() public{
        deployer = new DeployMoodNFT();
    
    }

    function testSvgToUriWorks() public view {
        string memory expectedExampleUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cHM6Ly93d3d3Lncub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+IDx0ZXh0IHg9IjAiIHk9IjE1IiBmaWxsPSJibGFjayI+IFlvdSBkZWNvZGVkIHRoaXMgPC90ZXh0Pjwvc3ZnPg==";
        // expectedExampleUri was derived by running `  base64 -i img/example.svg ` in terminal. Plus adding the baseURL prefix.
        string memory svg = '<svg xmlns="https://wwww.w.org/2000/svg" width="500" height="500"> <text x="0" y="15" fill="black"> You decoded this </text></svg>';
        string memory actualexampleUri = deployer.convertSvgToImageURI(svg); // Tests the func from the DeployMoodNFT.s.sol

        console.log("Encoded svg in Base64 is: ", Base64.encode(bytes(string(abi.encodePacked(svg)))));
        console.log("Derived expectedExampleUri is: ", expectedExampleUri);
        assert(keccak256(abi.encodePacked(expectedExampleUri)) == keccak256(abi.encodePacked(actualexampleUri)));
    }
}