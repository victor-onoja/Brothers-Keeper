//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

interface IMarketPlace {
    event CreatedTable (
        address owner,
        string statement
    );

    event Listed (
        address seller,
        uint listingId,
        address token,
        uint tokenId,
        uint price
    );

    event Sold (
        address buyer,
        uint listingId,
        address token,
        uint tokenId,
        uint price
    );

    event Cancelled (
        address seller,
        uint listingId,
        address token,
        uint tokenId
    );

    enum ListingStatus {
        Active,
        Sold,
        Cancelled
    }

    struct Listing {
        ListingStatus status;
        address seller;
        address token;
        uint tokenId;
        uint price;
    }

    function listToken(address token, uint tokenId, uint price) external;
    function cancelListing(uint listingId) external;
    function buyToken(uint listingId) external payable;
    function createTable (uint tableId, string calldata prefix) external;
}