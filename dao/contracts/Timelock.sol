//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin4.8.0/contracts/governance/extensions/TimelockController.sol";

contract TimeLock is TimelockController {

   constructor (
    uint256 minDelay,
    address[] memory proposers,
    address[] memory executors
   ) TimelockController (minDelay, proposers, executors) {
   
   }
 
}