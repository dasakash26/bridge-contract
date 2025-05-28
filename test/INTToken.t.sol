// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "src/INRToken.sol";

contract TestINRToken is Test {
    INRToken c;
    address akash = address(0x123);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    function setUp() public {
        c = new INRToken(6969);
    }

    function testInitialBalance() public {
        uint256 amount = 6969 * 10 ** c.decimals();

        assertEq(c.balanceOf(address(this)), amount);
    }

    function testTransfer() public {
        uint256 amount = 6969 * 10 ** c.decimals();
        c.transfer(akash, amount);

        assertEq(c.balanceOf(akash), amount);
    }

    function testMint() public {
        uint256 amount = 6969 * 10 ** c.decimals();
        c.mint(akash, amount);

        assertEq(c.balanceOf(akash), amount);
    }

    function testAllowance() public {
        uint256 initBal = 6969 * 10 ** c.decimals();
        uint256 amount = 100 * 10 ** c.decimals();
        c.approve(akash, amount);
        vm.prank(akash);
        c.transferFrom(address(this), akash, amount);

        assertEq(
            c.balanceOf(address(this)),
            initBal - amount,
            "owner's balance should drop by amount"
        );

        assertEq(
            c.balanceOf(akash),
            amount,
            "akash should receive the approved amount"
        );

        assertEq(
            c.allowance(address(this), akash),
            0,
            "allowance should be zero after transfer"
        );
        console.log("Token Allowance Check", address(this));
    }

    function testMintFail() public {
        uint256 amount = 6969 * 10 ** c.decimals();
        vm.prank(akash);
        vm.expectRevert("Ownable: caller is not the owner");
        c.mint(akash, amount);
    }

    function testTransferFail() public {
        uint256 amount = 6969 * 10 ** c.decimals();
        c.transfer(address(this), amount);
        vm.expectRevert();
        c.transfer(akash, 10 * amount);
    }

    function testAllowanceFail() public {
        uint256 initAmount = 6969 * 10 ** c.decimals();
        vm.prank(akash);
        vm.expectRevert();
        c.transferFrom(address(this), akash, 100);

        assertEq(
            c.balanceOf(address(this)),
            initAmount,
            "our balance must remain same"
        );

        assertEq(c.balanceOf(akash), 0, "akash must still have 0");
    }

    //test for emits
    function testTransferEmit() public {
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), akash, 100);
        c.transfer(akash, 100);
    }

    function testApproveEmit() public {
        vm.expectEmit(true, true, false, true);
        emit Approval(address(this), akash, 100);
        c.approve(akash, 100);
    }
}
