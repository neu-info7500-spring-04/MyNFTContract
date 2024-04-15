// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import "../src/MyNFT.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FakeERC20 is ERC20 {
    constructor() ERC20("FakeERC20", "F20") {
        _mint(msg.sender, 100 ether); // 給測試合約創建者一些代幣
    }
}

contract MyNFTTest is Test {
    MyNFT private myNFT;
    FakeERC20 private token;

    function setUp() public {
        // 假設ERC20合約已部署在此地址
        token = new FakeERC20();
        myNFT = new MyNFT(address(token));
        token.approve(address(myNFT), type(uint256).max); // 預先批准最大金額
    }

    function testInitialSettings() public {
        assertEq(myNFT.name(), "MyNFT");
        assertEq(myNFT.symbol(), "MN");
    }

    function testMintNFT() public {
        string memory tokenURI = "https://ipfs.io/ipfs/bafkre...";
        uint256 price = 1 ether;
        uint256 tokenId = myNFT.createToken(tokenURI, price);
        assertEq(myNFT.tokenPrices(tokenId), price);
        assertEq(myNFT.ownerOf(tokenId), address(this));
    }

    function testSetTokenPrice() public {
        string memory tokenURI = "https://ipfs.io/ipfs/bafkre...";
        uint256 price = 1 ether;
        uint256 tokenId = myNFT.createToken(tokenURI, price);
        myNFT.setTokenPrice(tokenId, 2 ether);
        assertEq(myNFT.tokenPrices(tokenId), 2 ether);
    }

    function testBuyNFT() public {
        string memory tokenURI = "https://ipfs.io/ipfs/bafkre...";
        uint256 price = 1 ether;

        // 創建NFT並設定銷售價格
        uint256 tokenId = myNFT.createToken(tokenURI, price);
        address seller = address(this);
        address buyer = address(0x123);

        // 買家獲得一些ERC20代幣
        token.transfer(buyer, 100 ether);

        // 買家授權合約從其賬戶中扣款
        vm.prank(buyer);
        token.approve(address(myNFT), price);

        // 買家購買NFT
        vm.prank(buyer);
        myNFT.buyToken(tokenId);

        // 驗證
        assertEq(
            myNFT.ownerOf(tokenId),
            buyer,
            "The buyer should now own the NFT"
        );
        assertEq(
            token.balanceOf(buyer),
            99 ether,
            "Buyer should have spent 1 ether on the NFT"
        );
        assertEq(
            token.balanceOf(seller),
            1 ether,
            "Seller should have received 1 ether from the buyer"
        );
    }
}
