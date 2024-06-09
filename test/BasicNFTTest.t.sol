// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol";
import {BasicNFT} from "src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT private deployer;
    BasicNFT private basicNFT;
    address public USER = makeAddr("USER");
    string public constant PUG_URI =
        "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png";

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory actualName = "Doggie";
        string memory expectedName = basicNFT.name(); // Since BasicNFT is ERC721.sol
        /**
         * assert(actualName == expectedName) wouldn't work because strings are an [] of bytes
         * And elements of [] can't be compared
         * What to do rather is to get the hashing of these []s
         * And assert that they are equal.
         * REMEMBER: No 2 objects can have same hashings.
         * We do that using keccak256(abi.encode())
         * Although the video used keccack256(abi.encodePacked(arg); DIFFERENCE?
         */

        assert(
            keccak256(abi.encode(actualName)) ==
                keccak256(abi.encode(expectedName))
        );
    }

    function testSymbolIsCorrect() public view {
        string memory actualSymbol = "DOG";
        string memory expectedSymbol = basicNFT.symbol();

        assert(
            keccak256(abi.encodePacked(actualSymbol)) ==
                keccak256(abi.encodePacked(expectedSymbol))
        );
    }

    function testUserCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNFT.mint(PUG_URI);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG_URI)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );

        // basicNFT.tokenURI(0) means function tokenURI(uint256 tokenId) in basicNFT
        // The first minted NFT has a tokenId of 0, as set in constructor.
        // Then it is incremented.
    }
}
