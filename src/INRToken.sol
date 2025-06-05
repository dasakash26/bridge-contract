// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

//assume this is deployed on ethereum chain
contract INRToken is ERC20, Ownable {
    address owner;

    constructor(uint amount) ERC20("INRToken", "INRT") Ownable(msg.sender) {
        _mint(msg.sender, amount * 10 ** decimals());
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address account, uint balance) public  {
        _burn(account, balance);
    }
}
