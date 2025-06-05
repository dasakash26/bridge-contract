// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20";

contract BridgeETH is Ownable {
    address public tokenAddress;
    mapping(address => uint256) public pendingBalance;

    event Deposit(address indexed depositor, uint256 amount);

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    function deposit(IERC20 _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress, "Invalid token");
        require(
            _tokenAddress.allowance(msg.sender, address(this)) >= _amount,
            "Insufficient allowance"
        );

        bool success = _tokenAddress.transferFrom(
            msg.sender,
            address(this),
            _amount
        );
        require(success, "TransferFrom failed");

        emit Deposit(msg.sender, _amount);
    }

    function withdraw(IERC20 _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress, "Invalid token");
        require(
            pendingBalance[msg.sender] >= _amount,
            "Insufficient pending balance"
        );

        pendingBalance[msg.sender] -= _amount;

        bool success = _tokenAddress.transfer(msg.sender, _amount);
        require(success, "Transfer failed");
    }

    function burnedOnOtherSide(
        address userAccount,
        uint256 _amount
    ) public onlyOwner {
        pendingBalance[userAccount] += _amount;
    }
}
