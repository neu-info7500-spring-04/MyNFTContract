// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract MyNFTTest is Test {
    MyNFT public myNFT;

    function setUp() public {
        myNFT = new MyNFT();
    }

    function testCreateToken() public {
        string memory tokenURI = "ipfs://bafybeib6ayylbtsu3te7kam4kjsb6foizhbuez5leffgyeoxuaxaxcp5ni/DALL%C2%B7E%20Recruitment%20Image.webp";
        uint256 newItemId = myNFT.createToken(tokenURI);
        assertEq(myNFT.ownerOf(newItemId), address(this));
        assertEq(myNFT.tokenURI(newItemId), tokenURI);
    }
}