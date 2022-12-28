//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;


import "@openzeppelin4.8.0/contracts/token/ERC721/extensions/ERC721Votes.sol";
import "contracts/Transfer.sol";


contract BrothersKeeperNFT is 
    Transfer,
    ERC721Votes
    {

    uint private tokenId;
    string private _baseURIstring;
    uint256 private immutable tokenPrice;


    constructor (uint256 _tokenPrice)
        ERC721 ("BrothersKeeperNFT", "BK")
        EIP712("BrothersKeeperNFT", "1") 
    {
        tokenPrice = _tokenPrice;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseURIstring;
    }

    function setBaseUri(string calldata newUri) external onlyOwner() {
        _baseURIstring = newUri;
    }

    function mint(address reciepient) public payable {
        require(msg.value >= tokenPrice * 1 ether, "Insufficient funds to mint Token");
        _mint(reciepient, tokenId);
        tokenId ++;
    }

    function governorMint(address destination) public onlyOwner {
        _mint(destination, tokenId);
        tokenId ++;
    }
}
