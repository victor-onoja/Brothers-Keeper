//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;


import "@openzeppelin4.8.0/contracts/utils/Timers.sol";
import "@openzeppelin4.8.0/contracts/utils/Strings.sol";
import "@openzeppelin4.8.0/contracts/governance/utils/IVotes.sol";
import "@openzeppelin4.8.0/contracts/governance/TimelockController.sol";
//import "@openzeppelin4.8.0";

import "../../interfaces/ITablelandTables.sol";
import "../../interfaces/ITablelandController.sol";
import "../../interfaces/IBrothersKeeperNFT.sol";



contract Governor {

    uint8 constant private _reward = 20;
    uint16 immutable public blockTime;
    uint256 immutable private _proposalId;
    string private propposalsPrefix;
    string private votesPrefix;
    ITablelandTables immutable private _tableland;
    IBrothersKeeperNFT immutable private _brothersKeeperNFT;
    TimelockController private _timelock;
    IVotes public immutable token;

    event TimelockChange(address oldTimelock, address newTimelock);

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

    mapping (uint256 => ProposalDetails) private _proposals;
    mapping (address => uint8) private _reputation;
    mapping(uint256 => bytes32) private _timelockIds;

    constructor (address registry,
                 address token,
                 uint16 blockTimeSecs,
                 uint256 quorumNumeratorValue,
                 TimelockController _timelock,
                 IVotes tokenAddress)
        {

        token = tokenAddress;
        _tableland = ITablelandTables(registry);
        _brothersKeeperNFT = IBrothersKeeperNFT(token);
        blockTime = blockTimeSecs;
        _updateTimelock(_timelock);
        _proposalId = _create(
            string.concat(

            )
        );
    }

    function _create(string memory statement) private returns(uint _tableId) {
        _tableId = _tableland.createTable(
            address(this),
            statement
        );
    }

    function _run (address caller, uint256 tableId, string memory statement) private {
        _tableland.runSQL(
            caller, tableId, statement);
    }

    function updateTimelock(TimelockController newTimelock) external virtual onlyGovernance {
        _updateTimelock(newTimelock);
    }

    function _updateTimelock(TimelockController newTimelock) private {
        emit TimelockChange(address(_timelock), address(newTimelock));
        _timelock = newTimelock;
    }

    function COUNTING_MODE() public pure virtual override returns (string memory) {
        return "support=bravo&quorum=for,abstain";
    }

    function proposalEta(uint256 proposalId) public view virtual override returns (uint256) {
        uint256 eta = _timelock.getTimestamp(_timelockIds[proposalId]);
        return eta == 1 ? 0 : eta; // _DONE_TIMESTAMP (1) should be replaced with a 0 value
    }


    function reward() internal {

    }

    function _getVotes(
        address account,
        uint256 blockNumber,
        bytes memory /*params*/
    ) internal view virtual override returns (uint256) {
        return token.getPastVotes(account, blockNumber);
    }

    function _voteSucceeded(uint256 proposalId) internal view virtual override returns (bool) {
        ProposalDetails storage proposalVote = _proposals[proposalId];

        return proposalVote.forVotes > proposalVote.againstVotes;
    }


    function votingDelay()
        public
        view
        override(IGovernor, GovernorSettings)
        returns (uint256)
    {
        return super.votingDelay();
    }

    function votingPeriod()
        public
        view
        override(IGovernor, GovernorSettings)
        returns (uint256)
    {
        return super.votingPeriod();
    }
    
    function quorum(uint256 blockNumber)
        public
        view
        override(IGovernor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }

    function proposalThreshold()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.proposalThreshold();
    }

    function _executor()
        internal
        view
        returns (address)
    {
        return address(_timelock);
    }
    
    function timelock() public view virtual override returns (address) {
        return address(_timelock);
    }

}