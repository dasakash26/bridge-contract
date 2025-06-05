// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

//assume this is the wrapped version of INRToken on base network
contract wINRToken is ERC20, Ownable {
    constructor(uint amount) ERC20("wINRToken", "wINRT") Ownable(msg.sender) {
        _mint(msg.sender, amount * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address account, uint balance) public {
        _burn(account, balance);
    }
}
