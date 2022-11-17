//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;


import "@openzeppelin4.8.0/contracts/governance/Governor.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";
import "@openzeppelin4.8.0/contracts/governance/extensions/GovernorTimelockControl.sol";
import "@openzeppelin4.8.0/contracts/utils/Timers.sol";
import "@openzeppelin4.8.0/contracts/utils/Strings.sol";
import "@openzeppelin4.8.0/contracts/token/ERC721/utils/ERC721Holder.sol";
import "../interfaces/ITablelandTables.sol";
import "../interfaces/ITablelandController.sol";
import "../interfaces/IBrothersKeeperNFT.sol";


contract BrothersKeeperGovenor is
    ERC721Holder {

    uint8 constant reward = 20;
    uint256 private _proposalId;
    ITablelandTables private _tableland;
    IBrothersKeeperNFT private _brothersKeeperNFT;

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


    constructor (address registry, address token) {
        _tableland = ITablelandTables(registry);
        _brothersKeeperNFT = IBrothersKeeperNFT(token);
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

    function _create() private {

    }

    function _run() private {

    }

    function reward(address brother, uint8 amount) external onlyGovernance() {

    }

    // necessary overrides
}