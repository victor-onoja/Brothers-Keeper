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



contract Gov {

    uint8 constant internal _reward = 20;
    uint16 immutable public blockTime;
    uint256 immutable internal _proposalId;
    string internal proposalsPrefix;
    string internal votesPrefix;
    ITablelandTables immutable internal _tableland;
    IBrothersKeeperNFT immutable internal _brothersKeeperNFT;
    TimelockController internal _timelock;
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
        address proposer;
        uint256 blockProposed;
        uint256 forVotes;
        uint256 againstVotes;
        uint256 abstainVotes;
        ProposalState state;
        uint256 tableId;
        uint256 proposalId;
    }

    mapping (uint256 => ProposalDetails) internal _proposals;
    mapping (address => uint8) internal _reputation;
    mapping(uint256 => bytes32) internal _timelockIds;

    modifier isActive (uint proposal) {
        require(proposal.state == ProposalState.Active,
        "vote is not active");
        _;
    }

    modifier isStored (uint proposal) {
        require(proposal.state == ProposalState.Active,
        "vote is not Stored");
        _;
    }

    constructor (address registry,
                 address _token,
                 uint16 blockTimeSecs,
                 uint256 quorumNumeratorValue,
                 TimelockController __timelock,
                 IVotes tokenAddress)
        {

        token = tokenAddress;
        _tableland = ITablelandTables(registry);
        _brothersKeeperNFT = IBrothersKeeperNFT(_token);
        blockTime = blockTimeSecs;
        _updateTimelock(__timelock);
        proposalsPrefix = "propoal_BK_";
        _proposalId = _create(
            string.concat(
                "CREATE TABLE ",
                proposalsPrefix,
                "_",
                Strings.toString(chain.id),
                " (id INTEGER PRIMARY KEY, targets TEXT, value TEXT, signature TEXT, calldatas TEXT, proposer TEXT, blockProposed INTEGER, forVotes INTEGER, against INTEGER, abstain INTEGER, state INTEGER, tableId INTEGER, UNIQUE(id));"
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

    function hashProposal(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) public pure virtual override returns (uint256) {
        return uint256(keccak256(abi.encode(targets, values, calldatas, descriptionHash)));
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


    function reward(address reciepient, uint amount) internal {
        _reputation[reciepient] += amount;
    }

    function _getVotes(
        address account,
        uint256 blockNumber,
        bytes memory /*params*/
    ) internal view virtual override returns (uint256) {
        return token.getPastVotes(account, blockNumber);
    }

    function _voteSucceeded (uint256 proposalId) internal isStored(proposalId) returns (bool) {
        ProposalDetails storage proposalVote = _proposals[proposalId];

        return proposalVote.forVotes > proposalVote.againstVotes;
    }


    function votingDelay()
        public
        view
        returns (uint256)
    {
        return uint(120 / blockTime); /* 2 minutes in seconds*/
    }

    function votingPeriod()
        public
        view
        returns (uint256)
    {
        return uint(120000 / blockTime); /* 2 days in seconds*/
    }
    
    function quorum (uint256 proposalId) internal isStored(proposalId) returns (uint256)
    {
        blockNum = _proposals[proposalId].blockProposed + votingDelay();
        return (token.getPastTotalSupply(blockNum) * quorumNumerator(blockNum)) / quorumDenominator();
    }

    function proposalThreshold()
        public
        view
        returns (uint8)
    {
        return 1;
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