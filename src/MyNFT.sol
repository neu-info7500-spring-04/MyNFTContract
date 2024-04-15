// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // 新增：用於保存每個NFT售價的映射
    mapping(uint256 => uint256) public tokenPrices;

    // 新增：ERC20支付代幣的地址
    IERC20 public paymentToken;

    constructor(address _paymentTokenAddress) ERC721("MyNFT", "MN") {
        paymentToken = IERC20(_paymentTokenAddress);
    }

    // 修改createToken函數以允許設置售價
    function createToken(
        string memory tokenURI,
        uint256 price
    ) external returns (uint256) {
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        // 新增：設置NFT售價
        tokenPrices[newItemId] = price;

        _tokenIds.increment();

        return newItemId;
    }

    // 新增：設置NFT售價的功能
    function setTokenPrice(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "Only owner can set price");
        tokenPrices[tokenId] = price;
    }

    // 新增：購買NFT的功能
    function buyToken(uint256 tokenId) public {
        uint256 price = tokenPrices[tokenId];
        require(price > 0, "This token is not for sale");
        require(
            paymentToken.transferFrom(msg.sender, ownerOf(tokenId), price),
            "Payment failed"
        );

        _transfer(ownerOf(tokenId), msg.sender, tokenId);
        tokenPrices[tokenId] = 0; // Optionally reset the token price after purchase
    }
}
