// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface GovToken {
    function snapshot() external view returns (address[] memory);
}

contract Borda {
    Proposal[] public proposals;

    struct Proposal {
        address owner;
        address tokenAddr;
        uint256 candidateCount;
        address[] snapshot;
        mapping(address => uint8[]) votes;
        mapping(uint8 => string) candidateData;
        bool lock;
    }

    function NewProposal(address _votetoken, uint256 _candidateCount)
        external
        returns (uint256)
    {
        GovToken token = GovToken(_votetoken);
        address[] memory snapshot = token.snapshot();
        Proposal storage newProposal = proposals.push();
        newProposal.owner = msg.sender;
        newProposal.tokenAddr = _votetoken;
        newProposal.candidateCount = _candidateCount;
        newProposal.snapshot = snapshot;
        return proposals.length - 1;
    }

    function Vote(uint256 _proposalId, uint8[] memory vote) external {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.lock);
        bool check;
        for (uint256 i = 0; i < proposal.snapshot.length; i++) {
            if (proposal.snapshot[i] == msg.sender) {
                check = true;
                break;
            }
        }

        require(check, "not in snapshot");
        require(vote.length == proposal.candidateCount, "wrong length");
        proposal.votes[msg.sender] = vote;
    }
}
