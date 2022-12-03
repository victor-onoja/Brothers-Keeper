// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../interfaces/ITablelandTables.sol";


contract TablelandTables {
    event tableCreated(
        uint tableId,
        address creator,
        string statement);
    
    event Run(
        uint tableId,
        address executor,
        string tableName);

    mapping (uint => address) private tables;
    uint private Id = 0;

    function createTable (
        address owner,
        string memory statement) public payable returns (uint) {
        tables[Id] = owner;
        emit tableCreated(Id, owner, statement);
        Id ++;
        return Id -1;
    }


    function runSQL (address caller, uint tableId, string memory statement) public payable {
        require(tables[tableId] == caller, "table doesnt belong to caller");
        emit Run(tableId, caller, statement);
    }
}