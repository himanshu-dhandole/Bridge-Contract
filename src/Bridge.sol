// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BridgeContract {
    address public tokenAddress ;
    uint256 public balance ;
    mapping (address => uint256) pendingBalance ;
    event DepositEvent (address indexed Depositor , uint256 amount) ;
    constructor(address _tokenAddress){
        tokenAddress = _tokenAddress ;
    }

    function lock(IERC20 _tokenAddress , uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress) ;
        require(_tokenAddress.allowance(msg.sender , address(this)) >= _amount) ;
        require(_tokenAddress.transferFrom(msg.sender , address(this) , _amount)) ;
        emit DepositEvent(msg.sender, _amount);
    }

    function unlock(IERC20 _tokenAddress , uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount ;
        _tokenAddress.transfer(msg.sender ,_amount) ;
    }

    // this will be called by the central server 
    function burnerdOnOtherSide(address _userAddress , uint256 _amount) public onlyOwner {
        pendingBalance[_userAddress] += _amount ;
    }
}
