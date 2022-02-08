// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Borda {
    mapping(uint256 => Proposal) public proposals;

    struct Proposal {
        address owner;
        address tokenAddr;
        uint256 candidateCount;
        mapping(address => uint256) snapshot;
        mapping(address => uint8[]) votes;
        mapping(uint8 => string) candidateData;
    }

    function NewProposal(address _votetoken, uint256 _candidateCount)
        external
    {}
}
