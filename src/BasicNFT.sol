// SPDX-License_Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter; // Counter for NFT tokenId
    mapping(uint256 s_tokenCounter => string tokenUri) private s_tokenIdToUri;

    constructor() ERC721("Doggie", "DOG") { // name, symbol
        s_tokenCounter = 0;
    }

    function mint(string memory tokenUri) external {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter); // From ERC721.sol. Check Out!
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
