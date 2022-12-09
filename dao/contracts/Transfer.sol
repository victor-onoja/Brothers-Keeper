//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin4.8.0/contracts/access/Ownable.sol";
import "@openzeppelin4.8.0/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin4.8.0/contracts/token/ERC721/IERC721.sol";

contract Transfer is Ownable {

    event transferSent (
        address tokenAddress,
        address reciepient
    );

    function _sendCoin(address payable recipient, uint amount) internal {
        (bool success, ) = recipient.call{value: amount}("");
        require (success, "Transfer Failed.");
        emit transferSent(address(0),recipient);
    }
    
    function sendCoin(address payable recipient, uint amount) external onlyOwner() {
        require(address(this).balance >= amount, "Insufficient funds");
        _sendCoin(recipient,amount);
    }

    function _sendERC20Token(address tokenAdd, address reciepient, uint amount) internal {
        IERC20(tokenAdd).transfer(reciepient, amount);
        emit transferSent(tokenAdd, reciepient);
    }

    function sendERC20Token(
        address tokenAdd, address reciepient, uint amount) external onlyOwner() {
        require(IERC20(tokenAdd).balanceOf(address(this)) >= amount,
            "Insufficient Funds");
        _sendERC20Token(tokenAdd,reciepient,amount);
    }

    function _sendERC721Token(
        address tokenAdd,
        address sender,
        address reciepient,
        uint tokenId) internal {

        IERC721(tokenAdd).transferFrom(sender, reciepient, tokenId);
        emit transferSent(tokenAdd, reciepient);
    }

    function sendERC721Token(
        address tokenAdd,
        address sender,
        address reciepient,
        uint tokenId) external onlyOwner() {
            
        _sendERC721Token(tokenAdd, sender, reciepient, tokenId);
    }

}