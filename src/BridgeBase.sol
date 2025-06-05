// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeBase is Ownable {
    address public tokenAddress;
    mapping(address => uint256) public pendingBalance;

    event Burn(address indexed burner, uint256 amount);

    constructor() Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    function mint() public {

    }

    function burn(address _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        _tokenAddress.burn(msg.sender, _amount);
        emit Burn(msg.sender, _amount);
    }

    function depositedOnOtherSide(
        address userAddress,
        uint256 _amount
    ) public onlyOwner {
        pendingBalance[userAddress] += _amount;
    }
}
