//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;


import "@openzeppelin4.8.0/contracts/governance/Governor.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorTimelockControl.sol";
import "@openzeppelin4.8.0/contracts/utils/Timers.sol";
import "@openzeppelin4.8.0/contracts/utils/Strings.sol";
import "@openzeppelin4.8.0/contracts/token/ERC721/utils/ERC721Holder.sol";
import "../interfaces/ITablelandTables.sol";
import "../interfaces/ITablelandController.sol";
import "../interfaces/IBrothersKeeperNFT.sol";


contract BrothersKeeperGovenor is
    ERC721Holder,
    GovernorVotes,
    GovernorVotesQuorumFraction,
    GovernorTimelockControl,
    GovernorSettings {

    uint8 constant private _reward = 20;
    uint16 immutable public blockTIme;
    uint256 immutable private _proposalId;
    string immutable private propposalsPrefix;
    string immutable private votesPrefix;
    ITablelandTables immutable private _tableland;
    IBrothersKeeperNFT immutable private _brothersKeeperNFT;


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

    mapping (uint256 => ProposalDetails) private _proposals;
    mapping (address => uint8) private _reputation;


    constructor (address registry, address token, uint16 blockTimeSecs, TimelockController _timelock)
        GovernorVotes(IVotes(token))
        GovernorVotesQuorumFraction(10)
        GovernorTimelockControl(_timelock)
        GovernorSettings() {

        _tableland = ITablelandTables(registry);
        _brothersKeeperNFT = IBrothersKeeperNFT(token);
        blockTime = blockTimeSecs;
        _proposalId = _create(
            string.concat(

            )
        );
    }

    function votingDelay() public pure override returns (uint256) {
        return uint(60 / blockTime);
    }

    function votingPeriod() public pure override returns (uint256) {
        return uint(604800 /*number of second in a week*/ / blockTime);
    }

    function proposalThreshold() public pure override returns (uint256) {
        return 1;
    }

    function COUNTING_MODE() public pure virtual override returns (string memory) {
        return "support=bravo&quorum=for,abstain";
    }

    function _quorumReached(uint256 proposalId) internal view virtual override returns (bool) {
        ProposalVote storage proposalVote = _proposalVotes[proposalId];

        return quorum(proposalSnapshot(proposalId)) <= proposalVote.forVotes + proposalVote.abstainVotes;
    }

    function _voteSucceeded(uint256 proposalId) internal view virtual override returns (bool) {
        ProposalVote storage proposalVote = _proposalVotes[proposalId];

        return proposalVote.forVotes > proposalVote.againstVotes;
    }

    function countVotes(uint256 proposalId) public {

    }












    function propose(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        string memory description
    ) public virtual override returns (uint256) {}

    function castVote() {}

    function _castVote(
        uint256 proposalId,
        address account,
        uint8 support,
        string memory reason
    ) internal override returns (uint256) {}

    function cancel() {}

    function _cancel(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) internal override returns (uint256) {}

    function _create(string memory statement) private returns (uint tableId) {
        _tableId = _tableland.createTable(
            address(this),
            statement
        );
    }

    function _run (address caller, uint256 tableId, string memory statement) private {
        _tableland.runSQL(
            caller, tableId, statement);
    }

    function reward(address brother) external onlyGovernance() {
        _reputation[brother] += _reward;
        if (_reputation[brother] >= 100) {
            surplus = _reputation[brother] - 100;
            _brothersKeeperNFT.governorMint(brother);
            _reputation[brother] = surplus;
        }
    }

    // necessary overrides
}