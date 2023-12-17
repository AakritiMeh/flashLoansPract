// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;
import "hardhat/console.sol";
import "./Token.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

interface IReceiver {
    function receiveTokens(address tokenAddress, uint256 amount) external;
}

contract FlashLoan {
    using SafeMath for uint256;

    Token public token;
    uint256 public poolBalance;

    constructor(address tokenAddress) {
        require(tokenAddress != address(0), "Token address cannot be zero");
        token = Token(tokenAddress);
    }

    function depositTokens(uint256 amount) external payable {
        require(amount > 0, "Must deposit at least one token");
        // Transfer token from sender. Sender must have first approved them.
        token.transferFrom(msg.sender, address(this), amount);
        poolBalance = poolBalance.add(amount);
    }

    function flashLoan(uint256 borrowAmount) external payable {
        require(borrowAmount > 0, "Must borrow at least one token");

        uint256 balanceBefore = token.balanceOf(address(this));
        require(balanceBefore >= borrowAmount, "Not enough tokens in pool");

        // Ensured by the protocol via the `depositTokens` function
        assert(poolBalance == balanceBefore);

        token.transfer(msg.sender, borrowAmount);

        IReceiver(msg.sender).receiveTokens(address(token), borrowAmount);

        uint256 balanceAfter = token.balanceOf(address(this));
        require(
            balanceAfter >= balanceBefore,
            "Flash loan hasn't been paid back"
        );
    }
}