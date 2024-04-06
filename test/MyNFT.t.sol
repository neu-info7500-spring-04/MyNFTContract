// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import "../src/MyNFT.sol";

contract MyNFTTest is Test {
    MyNFT instance;

    function setUp() public {
        instance = new MyNFT();
    }

    function testMint() public {
        string
            memory dummyTokenUri = "ipfs://bafybeicgxqlzlzossxskc4mih5ldaeeb276wzy6i6urcbrnydi2t7iukcu/%E5%A5%A7%E5%88%A9%E7%B5%A6%E5%A4%A7%E9%A0%AD%E7%85%A7.png";
        uint256 tokenId = instance.createToken(dummyTokenUri);

        assertEq(dummyTokenUri, instance.tokenURI(tokenId));
    }
}
