// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract INRToken is ERC20{
    address owner;

    constructor(uint amount) ERC20("INRToken", "INRT") {
        _mint(msg.sender, amount * 10 ** decimals());
        owner = msg.sender;
    }

    modifier ownerOnly(){
        require(msg.sender==owner, "Ownable: caller is not the owner");
        _;
    }

    function mint(address to, uint256 amount) ownerOnly public{
        _mint(to, amount);
    }
}
