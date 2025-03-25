// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract token is ERC20 {
    

    constructor(
        string memory name,
        string memory symbol,
        uint256 initialsuply
    ) ERC20(name, symbol){
        _min(msg.sender, initialSupply);
    }

    
}
