// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IBrothersKeeperNFT {
    function mint(address reciepient) external payable;
    function governorMint(address destination) external;
    function sendCoin(address payable recipient, uint amount) external;
    function sendERC20Token(address tokenAdd, address reciepient,uint amount) external;
}