// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IWINR is IERC20 {
    function mint(address _to, uint256 _amount) external;
    function burn(address _from, uint256 _amount) external;
}
contract BridgeBase is Ownable {
    address public tokenAddress;
    mapping(address => uint256) public pendingBalance;

    event Burn(address indexed burner, uint256 amount);

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    function mint() public {

    }

    function burn(IWINR _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        _tokenAddress.burn(msg.sender, _amount);
        emit Burn(msg.sender, _amount);
    }

    function depositedOnOtherSide(
        IWINR userAddress,
        uint256 _amount
    ) public onlyOwner {
        pendingBalance[address(userAddress)] += _amount;
    }
}
