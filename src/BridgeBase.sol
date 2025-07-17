// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract BridgeBase {
    address private tokenAddress ;

    constructor(address _tokenAddress){
        tokenAddress = _tokenAddress ;
    }

    function withdraw() public {

    }

    function burn() public {

    }
}
