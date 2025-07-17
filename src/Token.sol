// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20 , Ownable {
    constructor() ERC20("CocoCoin","COC") Ownable(msg.sender) {
    }

    function mint(address _to ,uint256 _amount) public isOwner {
        _mint( _to ,  _amount) ;
    }
}
