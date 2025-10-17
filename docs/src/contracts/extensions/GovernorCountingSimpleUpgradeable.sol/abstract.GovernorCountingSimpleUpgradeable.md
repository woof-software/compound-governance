# GovernorCountingSimpleUpgradeable
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/extensions/GovernorCountingSimpleUpgradeable.sol)

**Inherits:**
Initializable, [GovernorUpgradeable](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md)

*Extension of {Governor} for simple, 3 options, vote counting.*


## State Variables
### GovernorCountingSimpleStorageLocation

```solidity
bytes32 private constant GovernorCountingSimpleStorageLocation =
    0xa1cefa0f43667ef127a258e673c94202a79b656e62899531c4376d87a7f39800;
```


## Functions
### _getGovernorCountingSimpleStorage


```solidity
function _getGovernorCountingSimpleStorage() private pure returns (GovernorCountingSimpleStorage storage $);
```

### __GovernorCountingSimple_init


```solidity
function __GovernorCountingSimple_init() internal onlyInitializing;
```

### __GovernorCountingSimple_init_unchained


```solidity
function __GovernorCountingSimple_init_unchained() internal onlyInitializing;
```

### COUNTING_MODE

*See [IGovernor-COUNTING_MODE](/contracts/extensions/GovernorCountingFractionalUpgradeable.sol/abstract.GovernorCountingFractionalUpgradeable.md#counting_mode).*


```solidity
function COUNTING_MODE() public pure virtual override returns (string memory);
```

### hasVoted

*See [IGovernor-hasVoted](/contracts/extensions/GovernorCountingFractionalUpgradeable.sol/abstract.GovernorCountingFractionalUpgradeable.md#hasvoted).*


```solidity
function hasVoted(uint256 proposalId, address account) public view virtual override returns (bool);
```

### proposalVotes

*Accessor to the internal vote counts.*


```solidity
function proposalVotes(uint256 proposalId)
    public
    view
    virtual
    returns (uint256 againstVotes, uint256 forVotes, uint256 abstainVotes);
```

### _quorumReached

*See [Governor-_quorumReached](/contracts/extensions/GovernorCountingFractionalUpgradeable.sol/abstract.GovernorCountingFractionalUpgradeable.md#_quorumreached).*


```solidity
function _quorumReached(uint256 proposalId) internal view virtual override returns (bool);
```

### _voteSucceeded

*See [Governor-_voteSucceeded](/contracts/extensions/GovernorCountingFractionalUpgradeable.sol/abstract.GovernorCountingFractionalUpgradeable.md#_votesucceeded). In this module, the forVotes must be strictly over the againstVotes.*


```solidity
function _voteSucceeded(uint256 proposalId) internal view virtual override returns (bool);
```

### _countVote

*See [Governor-_countVote](/contracts/extensions/GovernorCountingFractionalUpgradeable.sol/abstract.GovernorCountingFractionalUpgradeable.md#_countvote). In this module, the support follows the `VoteType` enum (from Governor Bravo).*


```solidity
function _countVote(uint256 proposalId, address account, uint8 support, uint256 totalWeight, bytes memory)
    internal
    virtual
    override
    returns (uint256);
```

## Structs
### ProposalVote

```solidity
struct ProposalVote {
    uint256 againstVotes;
    uint256 forVotes;
    uint256 abstainVotes;
    mapping(address voter => bool) hasVoted;
}
```

### GovernorCountingSimpleStorage
**Note:**
storage-location: erc7201:openzeppelin.storage.GovernorCountingSimple


```solidity
struct GovernorCountingSimpleStorage {
    mapping(uint256 proposalId => ProposalVote) _proposalVotes;
}
```

## Enums
### VoteType
*Supported vote types. Matches Governor Bravo ordering.*


```solidity
enum VoteType {
    Against,
    For,
    Abstain
}
```

