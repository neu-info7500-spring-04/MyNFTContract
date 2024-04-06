// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract MyNFTTest is Test {
    MyNFT public myNFT;
    address testAddress = address(0x123);

    function setUp() public {
        myNFT = new MyNFT();
    }

    function testCreateToken() public {
        string memory tokenURI = "ipfs://bafybeib6ayylbtsu3te7kam4kjsb6foizhbuez5leffgyeoxuaxaxcp5ni/DALL%C2%B7E%20Recruitment%20Image.webp";
        uint256 newItemId = myNFT.createToken(testAddress, tokenURI);
        
        assertEq(myNFT.ownerOf(newItemId), testAddress, "The NFT owner should be the test address");
        assertEq(myNFT.tokenURI(newItemId), tokenURI, "The NFT tokenURI should match the input");
    }

    function testMintNFTAndCheckSupply() public {
        string memory tokenURI1 = "ipfs://bafybeib6ayylbtsu3te7kam4kjsb6foizhbuez5leffgyeoxuaxaxcp5ni/DALL%C2%B7E%20Recruitment%20Image.webp";
        string memory tokenURI2 = "ipfs://bafybeib6ayylbtsu3te7kam4kjsb6foizhbuez5leffgyeoxuaxaxcp5ni/DALL%C2%B7E%20Recruitment%20Image.webp";
        
        uint256 newItemId1 = myNFT.createToken(testAddress, tokenURI1);
        uint256 newItemId2 = myNFT.createToken(testAddress, tokenURI2);
        
        assertEq(myNFT.ownerOf(newItemId1), testAddress, "The NFT owner should be the test address");
        assertEq(myNFT.tokenURI(newItemId1), tokenURI1, "The NFT tokenURI should match the input");
        assertEq(myNFT.tokenURI(newItemId2), tokenURI2, "The NFT tokenURI should match the input");
    }
}