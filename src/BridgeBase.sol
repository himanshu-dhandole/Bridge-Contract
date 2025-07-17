// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BridgeBase {
    address private tokenAddress ;
    mapping (address => uint156) pendingBalance ;
    event Burned (address indexed accountHolder , uint256 amount) ;

    constructor(address _tokenAddress){
        tokenAddress = _tokenAddress ;
    }

    function withdraw(IERC20 _tokenAddress , uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount ;
        _tokenAddress.mint(msg.sender , _amount) ;
    }

    function burn(IERC20 _tokenAddress , uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        require(_tokenAddress.burn(msg.sender , _amoount));
        emit Burned(msg.sender, _amount);
    }

    function depositedOnOtherSide(address _userAddress , uint256 _amount) public onlyOwner{
        pendingBalance[_userAddress] += _amount ;
    }
}
