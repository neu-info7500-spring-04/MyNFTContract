// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage {
    uint256 private _tokenId;

    constructor() ERC721("MyNFT", "MN") {
        _tokenId = 0;
    }

    function createToken(string memory tokenURI) public returns (uint256) {
        _tokenId += 1;
        uint256 newItemId = _tokenId;
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
