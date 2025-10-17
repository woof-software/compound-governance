# GovernorAlpha
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/test/GovernorAlpha.sol)


## State Variables
### name
The name of this contract


```solidity
string public constant name = "Compound Governor Alpha";
```


### timelock
The address of the Compound Protocol Timelock


```solidity
TimelockInterface public timelock;
```


### comp
The address of the Compound governance token


```solidity
CompInterface public comp;
```


### guardian
The address of the Governor Guardian


```solidity
address public guardian;
```


### proposalCount
The total number of proposals


```solidity
uint256 public proposalCount;
```


### proposals
The official record of all proposals ever proposed


```solidity
mapping(uint256 => Proposal) public proposals;
```


### latestProposalIds
The latest proposal for each proposer


```solidity
mapping(address => uint256) public latestProposalIds;
```


### DOMAIN_TYPEHASH
The EIP-712 typehash for the contract's domain


```solidity
bytes32 public constant DOMAIN_TYPEHASH =
    keccak256("EIP712Domain(string name,uint256 chainId,address verifyingContract)");
```


### BALLOT_TYPEHASH
The EIP-712 typehash for the ballot struct used by the contract


```solidity
bytes32 public constant BALLOT_TYPEHASH = keccak256("Ballot(uint256 proposalId,bool support)");
```


## Functions
### quorumVotes

The number of votes in support of a proposal required in order for a quorum to be reached and for a vote to succeed


```solidity
function quorumVotes() public pure returns (uint256);
```

### proposalThreshold

The number of votes required in order for a voter to become a proposer


```solidity
function proposalThreshold() public pure returns (uint256);
```

### proposalMaxOperations

The maximum number of actions that can be included in a proposal


```solidity
function proposalMaxOperations() public pure returns (uint256);
```

### votingDelay

The delay before voting on a proposal may take place, once proposed


```solidity
function votingDelay() public pure returns (uint256);
```

### votingPeriod

The duration of voting on a proposal, in blocks


```solidity
function votingPeriod() public pure virtual returns (uint256);
```

### constructor


```solidity
constructor(address timelock_, address comp_, address guardian_) public;
```

### propose


```solidity
function propose(
    address[] memory targets,
    uint256[] memory values,
    string[] memory signatures,
    bytes[] memory calldatas,
    string memory description
) public returns (uint256);
```

### queue


```solidity
function queue(uint256 proposalId) public;
```

### _queueOrRevert


```solidity
function _queueOrRevert(address target, uint256 value, string memory signature, bytes memory data, uint256 eta)
    internal;
```

### execute


```solidity
function execute(uint256 proposalId) public payable;
```

### cancel


```solidity
function cancel(uint256 proposalId) public;
```

### getActions


```solidity
function getActions(uint256 proposalId)
    public
    view
    returns (address[] memory targets, uint256[] memory values, string[] memory signatures, bytes[] memory calldatas);
```

### getReceipt


```solidity
function getReceipt(uint256 proposalId, address voter) public view returns (Receipt memory);
```

### state


```solidity
function state(uint256 proposalId) public view returns (ProposalState);
```

### castVote


```solidity
function castVote(uint256 proposalId, bool support) public;
```

### castVoteBySig


```solidity
function castVoteBySig(uint256 proposalId, bool support, uint8 v, bytes32 r, bytes32 s) public;
```

### _castVote


```solidity
function _castVote(address voter, uint256 proposalId, bool support) internal;
```

### __acceptAdmin


```solidity
function __acceptAdmin() public;
```

### __abdicate


```solidity
function __abdicate() public;
```

### __queueSetTimelockPendingAdmin


```solidity
function __queueSetTimelockPendingAdmin(address newPendingAdmin, uint256 eta) public;
```

### __executeSetTimelockPendingAdmin


```solidity
function __executeSetTimelockPendingAdmin(address newPendingAdmin, uint256 eta) public;
```

### add256


```solidity
function add256(uint256 a, uint256 b) internal pure returns (uint256);
```

### sub256


```solidity
function sub256(uint256 a, uint256 b) internal pure returns (uint256);
```

### getChainId


```solidity
function getChainId() internal view returns (uint256);
```

## Events
### ProposalCreated
An event emitted when a new proposal is created


```solidity
event ProposalCreated(
    uint256 id,
    address proposer,
    address[] targets,
    uint256[] values,
    string[] signatures,
    bytes[] calldatas,
    uint256 startBlock,
    uint256 endBlock,
    string description
);
```

### VoteCast
An event emitted when a vote has been cast on a proposal


```solidity
event VoteCast(address voter, uint256 proposalId, bool support, uint256 votes);
```

### ProposalCanceled
An event emitted when a proposal has been canceled


```solidity
event ProposalCanceled(uint256 id);
```

### ProposalQueued
An event emitted when a proposal has been queued in the Timelock


```solidity
event ProposalQueued(uint256 id, uint256 eta);
```

### ProposalExecuted
An event emitted when a proposal has been executed in the Timelock


```solidity
event ProposalExecuted(uint256 id);
```

## Structs
### Proposal

```solidity
struct Proposal {
    uint256 id;
    address proposer;
    uint256 eta;
    address[] targets;
    uint256[] values;
    string[] signatures;
    bytes[] calldatas;
    uint256 startBlock;
    uint256 endBlock;
    uint256 forVotes;
    uint256 againstVotes;
    bool canceled;
    bool executed;
    mapping(address => Receipt) receipts;
}
```

### Receipt
Ballot receipt record for a voter


```solidity
struct Receipt {
    bool hasVoted;
    bool support;
    uint96 votes;
}
```

## Enums
### ProposalState
Possible states that a proposal may be in


```solidity
enum ProposalState {
    Pending,
    Active,
    Canceled,
    Defeated,
    Succeeded,
    Queued,
    Expired,
    Executed
}
```

