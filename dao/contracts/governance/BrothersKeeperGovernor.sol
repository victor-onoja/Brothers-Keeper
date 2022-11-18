//SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;


import "@openzeppelin4.8.0/contracts/utils/Timers.sol";
import "@openzeppelin4.8.0/contracts/utils/Strings.sol";
import "./Governor.sol";
import "../../interfaces/ITablelandTables.sol";
import "../../interfaces/ITablelandController.sol";
import "../../interfaces/IBrothersKeeperNFT.sol";
import "../../interfaces/IBrothersKeeperGovernor.sol";


contract BrothersKeeperGovenor is
    Govenor,
    IBrothersKeeperGovernor
    {

    constructor(address registry,
                 address token,
                 uint16 blockTimeSecs,
                 uint256 quorumNumeratorValue,
                 TimelockController _timelock,
                 IVotes tokenAddress) 
        Govenor(registry,
                token,
                blockTimeSecs,
                quorumNumeratorValue,
                _timelock,
                tokenAddress
        )
    {
    }

    modifier isActive (ProposalDetails proposal) {
        require(proposal.state == ProposalState.Active,
        "vote is not active");
        _;
    }

    function _getVotes(
        address account,
        uint256 blockNumber,
        bytes memory /*params*/
    ) internal view virtual override returns (uint256) {
        return token.getPastVotes(account, blockNumber);
    }

    function _castVote(
        uint256 proposalId
    ) internal virtual returns (uint256) {

        return _castVote(proposalId, account, support, reason, _defaultParams());
    }

    function castVote(
        uint256 proposalId
    ) internal virtual isActive(_proposals[proposalId]) returns (uint256) {
        _castVote(proposalId);
    }

    function _quorumReached(uint256 proposalId) internal view virtual override returns (bool) {
        ProposalDetails storage proposalVote = _proposals[proposalId];

        return quorum(proposalSnapshot(proposalId)) <= proposalVote.forVotes + proposalVote.abstainVotes;
    }

    function countVotes(uint256 proposalId) public {

    }    

    function quorum(uint256 blockNumber)
        public
        view
        override(IGovernor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }

    function state(uint256 proposalId)
        public
        view
        override(Governor, GovernorTimelockControl)
        returns (ProposalState)
    {
        return super.state(proposalId);
    }

    function propose(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, string memory description)
        public
        override(Governor, IGovernor)
        returns (uint256)
    {
        return super.propose(targets, values, calldatas, description);
    }

    function _execute(uint256 proposalId) internal
    {
    }

    function close() internal {

    }

    function _cancel(uint256 proposalId)
        internal
        returns (uint256)
    {
        return super._cancel(targets, values, calldatas, descriptionHash);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(Governor, GovernorTimelockControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

}