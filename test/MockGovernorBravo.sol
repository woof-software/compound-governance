// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract MockGovernorBravo {
    uint256 private _proposalCount;

    constructor(uint256 initialProposalCount) {
        _proposalCount = initialProposalCount;
    }

    function proposalCount() external view returns (uint256) {
        return _proposalCount;
    }

    function setProposalCount(uint256 newCount) external {
        _proposalCount = newCount;
    }
}
