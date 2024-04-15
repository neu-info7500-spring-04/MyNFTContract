// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestUSDC is ERC20 {
    constructor() ERC20("Test USDC", "USDC") {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals()))); // 發行100萬個代幣給部署者
    }

    function mintToCaller() public {
        _mint(msg.sender, 10000 * (10 ** uint256(decimals())));
    }
}
