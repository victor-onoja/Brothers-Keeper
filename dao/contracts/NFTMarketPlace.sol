//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin4.8.0/contracts/ownership/Ownable.sol";
import "@openzeppelin4.8.0/contracts/token/ERC721/utils/ERC721Holder.sol";
import "../interfaces/ITablelandTables.sol";
import "../interfaces/ITablelandController.sol";


contract MarketPlace is ERC721Holder, Ownable {

    uint8 immutable private _fee;
    uint public tableId;

    event sale {

    }
    
    struct Listing {

    }

    constructor (uint8 fee) {
        _fee = fee
    }

    function _create() private {

    }

    function _run() private {

    }

    function listToken() private {

    }

    function cancelListing() private {

    }

    function buyToken() private {

    }

    function setTableId(uint tableId) external onlyOwner() {

    }

    function _sendCoin(address payable recipient, uint amount) private {
        (bool success, ) = recipient.call{value: amount}("");
        require (success, "Transfer Failed.");
        emit transferSent(address(0),recipient);
    }
    
    function sendCoin(address payable recipient, uint amount) external onlyOwner() {
        require(address(this).balance >= amount, "Insufficient funds");
        _sendCoin(recipient,amount);
    }

    function _sendToken(address tokenAdd, address reciepient, uint amount) private {
        IERC20(tokenAdd).transfer(reciepient, amount);
        emit transferSent(tokenAdd, reciepient);
    }
    function sendToken(
        address tokenAdd, address reciepient,uint amount) external onlyOwner() {
        require(IERC20(tokenAdd).balanceOf(address(this)) >= amount,
            "Insufficient Funds");
        _sendToken(tokenAdd,reciepient,amount);
    }

}
