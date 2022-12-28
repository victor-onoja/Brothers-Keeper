// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IBrothersKeeperGovernor {

    enum ProposalState {
        Pending,
        Active,
        Canceled,
        Defeated,
        Succeeded,
        Resolved,
        Queued,
        Expired,
        Executed
    }

    enum VoteType {
        For,
        Against,
        Abstain
    }

    event ProposalCreated(
        uint256 proposalId,
        address proposer,
        address[] targets,
        uint256[] values,
        string[] signatures,
        bytes[] calldatas,
        uint256 startBlock,
        uint256 endBlock,
        string description
    );

    /**
     * @dev Emitted when a proposal is canceled.
     */
    event ProposalCanceled(uint256 proposalId);

    /**
     * @dev Emitted when a proposal is executed.
     */
    event ProposalExecuted(uint256 proposalId);

    /**
     * @dev Emitted when a vote is cast without params.
     *
     * Note: `support` values should be seen as buckets. Their interpretation depends on the voting module used.
     */
    event VoteCast(address indexed voter, uint256 proposalId, uint8 support, uint256 weight, string reason);

    /**
     * @dev Emitted when a vote is cast with params.
     *
     * Note: `support` values should be seen as buckets. Their interpretation depends on the voting module used.
     * `params` are additional encoded parameters. Their intepepretation also depends on the voting module used.
     */
    event VoteCastWithParams(
        address indexed voter,
        uint256 proposalId,
        uint8 support,
        uint256 weight,
        string reason,
        bytes params
    );

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