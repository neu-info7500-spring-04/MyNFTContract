// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721URIStorage {
    uint256 _tokenId;

    constructor() ERC721("MyNFT", "MN") {
        _tokenId = 0;
    }

    function createToken(address recipient, string memory tokenURI) public returns (uint256) {
        ++_tokenId;
        
        uint256 newItemId = _tokenId;
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
