// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IBrothersKeepersGovernor {
    enum ProposalState {
        Pending,
        Active,
        Canceled,
        Defeated,
        Succeeded,
        Queued,
        Expired,
        Executed
    }

    enum VoteType {
        For,
        Against,
        Abstain
    }

    struct ProposalDetails {
        address[] targets;
        uint256[] values;
        string[] signatures;
        bytes[] calldatas;
        bool saved;
        address proposer;
        uint256 blockProposed;
        uint256 forVotes;
        uint256 againstVotes;
        uint256 abstainVotes;
        ProposalState state;
        uint256 tableId;
        uint256 proposalId;
    }

    function votingDelay()
        external
        view
        returns (uint256);


    function votingPeriod()
        external
        view
        returns (uint256);
    

    function supportsInterface(bytes4 interfaceId)
        external
        view
        returns (bool);

    function proposalThreshold()
        external
        view
        returns (uint256);
    
    function propose(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, string memory description)
        external
        returns (uint256);
    
    function state(uint256 proposalId)
        external
        view
        returns (ProposalState);

    function quorum(uint256 blockNumber)
        external
        view
        returns (uint256);
    
    function cancel(uint blockNumber)
        external
        view
        returns (uint256);
    
    function execute(uint256 blockNumber)
        external
        view
        returns (uint256);
    
    function countVotes(uint256 blockNumber)
        external
        view
        returns (uint256);
    
    function vote(uint256 blockNumber)
        external
        view
        returns (uint256);
}