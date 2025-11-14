# GovernorBravoDelegate
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/GovernorBravoDelegate.sol)

**Inherits:**
[GovernorBravoDelegateStorageV3](/contracts/GovernorBravoInterfaces.sol/contract.GovernorBravoDelegateStorageV3.md), [GovernorBravoEvents](/contracts/GovernorBravoInterfaces.sol/contract.GovernorBravoEvents.md)

**Note:**
security-contact: security@compound.finance


## State Variables
### name
The name of this contract


```solidity
string public constant name = "Compound Governor Bravo";
```


### MIN_PROPOSAL_THRESHOLD
The minimum settable proposal threshold


```solidity
uint256 public constant MIN_PROPOSAL_THRESHOLD = 1000e18;
```


### MAX_PROPOSAL_THRESHOLD
The maximum settable proposal threshold


```solidity
uint256 public constant MAX_PROPOSAL_THRESHOLD = 100_000e18;
```


### MIN_VOTING_PERIOD
The minimum settable voting period


```solidity
uint256 public constant MIN_VOTING_PERIOD = 5760;
```


### MAX_VOTING_PERIOD
The max settable voting period


```solidity
uint256 public constant MAX_VOTING_PERIOD = 80_640;
```


### MIN_VOTING_DELAY
The min settable voting delay


```solidity
uint256 public constant MIN_VOTING_DELAY = 1;
```


### MAX_VOTING_DELAY
The max settable voting delay


```solidity
uint256 public constant MAX_VOTING_DELAY = 40_320;
```


### quorumVotes
The number of votes in support of a proposal required in order for a quorum to be reached and for a vote
to succeed


```solidity
uint256 public constant quorumVotes = 400_000e18;
```


### proposalMaxOperations
The maximum number of actions that can be included in a proposal


```solidity
uint256 public constant proposalMaxOperations = 10;
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
bytes32 public constant BALLOT_TYPEHASH = keccak256("Ballot(uint256 proposalId,uint8 support)");
```


### BALLOT_WITH_REASON_TYPEHASH
The EIP-712 typehash for the ballot with reason struct used by the contract


```solidity
bytes32 public constant BALLOT_WITH_REASON_TYPEHASH =
    keccak256("Ballot(uint256 proposalId,uint8 support,string reason)");
```


### PROPOSAL_TYPEHASH
The EIP-712 typehash for the proposal struct used by the contract


```solidity
bytes32 public constant PROPOSAL_TYPEHASH = keccak256(
    "Proposal(address[] targets,uint256[] values,string[] signatures,bytes[] calldatas,string description,uint256 proposalId)"
);
```


## Functions
### initialize

Used to initialize the contract during delegator constructor


```solidity
function initialize(
    address timelock_,
    address comp_,
    uint256 votingPeriod_,
    uint256 votingDelay_,
    uint256 proposalThreshold_
) public virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`timelock_`|`address`|The address of the Timelock|
|`comp_`|`address`|The address of the COMP token|
|`votingPeriod_`|`uint256`|The initial voting period|
|`votingDelay_`|`uint256`|The initial voting delay|
|`proposalThreshold_`|`uint256`|The initial proposal threshold|


### propose

Function used to propose a new proposal. Sender must have delegates above the proposal threshold


```solidity
function propose(
    address[] memory targets,
    uint256[] memory values,
    string[] memory signatures,
    bytes[] memory calldatas,
    string memory description
) public returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targets`|`address[]`|Target addresses for proposal calls|
|`values`|`uint256[]`|Eth values for proposal calls|
|`signatures`|`string[]`|Function signatures for proposal calls|
|`calldatas`|`bytes[]`|Calldatas for proposal calls|
|`description`|`string`|String description of the proposal|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|Proposal id of new proposal|


### proposeBySig

Function used to propose a new proposal. Sender must have delegates above the proposal threshold


```solidity
function proposeBySig(
    address[] memory targets,
    uint256[] memory values,
    string[] memory signatures,
    bytes[] memory calldatas,
    string memory description,
    uint256 proposalId,
    uint8 v,
    bytes32 r,
    bytes32 s
) public returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`targets`|`address[]`|Target addresses for proposal calls|
|`values`|`uint256[]`|Eth values for proposal calls|
|`signatures`|`string[]`|Function signatures for proposal calls|
|`calldatas`|`bytes[]`|Calldatas for proposal calls|
|`description`|`string`|String description of the proposal|
|`proposalId`|`uint256`|The id of the proposal to propose (reverted if this isn't the next proposal id)|
|`v`|`uint8`|The recovery byte of the signature|
|`r`|`bytes32`|Half of the ECDSA signature pair|
|`s`|`bytes32`|Half of the ECDSA signature pair|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|Proposal id of new proposal|


### proposeInternal


```solidity
function proposeInternal(
    address proposer,
    address[] memory targets,
    uint256[] memory values,
    string[] memory signatures,
    bytes[] memory calldatas,
    string memory description
) internal returns (uint256);
```

### queue

Queues a proposal of state succeeded


```solidity
function queue(uint256 proposalId) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The id of the proposal to queue|


### queueOrRevertInternal


```solidity
function queueOrRevertInternal(address target, uint256 value, string memory signature, bytes memory data, uint256 eta)
    internal;
```

### execute

Executes a queued proposal if eta has passed


```solidity
function execute(uint256 proposalId) external payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The id of the proposal to execute|


### cancel

Cancels a proposal if sender is the proposer or proposalGuardian. Can be called by anyone if the proposer
delegates dropped below proposal threshold.


```solidity
function cancel(uint256 proposalId) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The id of the proposal to cancel|


### getActions

Gets actions of a proposal


```solidity
function getActions(uint256 proposalId)
    external
    view
    returns (address[] memory targets, uint256[] memory values, string[] memory signatures, bytes[] memory calldatas);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|the id of the proposal|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`targets`|`address[]`|of the proposal actions|
|`values`|`uint256[]`|of the proposal actions|
|`signatures`|`string[]`|of the proposal actions|
|`calldatas`|`bytes[]`|of the proposal actions|


### getReceipt

Gets the receipt for a voter on a given proposal


```solidity
function getReceipt(uint256 proposalId, address voter) external view returns (Receipt memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|the id of proposal|
|`voter`|`address`|The address of the voter|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`Receipt`|The voting receipt|


### state

Gets the state of a proposal


```solidity
function state(uint256 proposalId) public view returns (ProposalState);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The id of the proposal|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`ProposalState`|Proposal state as a `ProposalState` enum|


### castVote

Cast a vote for a proposal


```solidity
function castVote(uint256 proposalId, uint8 support) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The id of the proposal to vote on|
|`support`|`uint8`|The support value for the vote. 0=against, 1=for, 2=abstain|


### castVoteBySig

Cast a vote for a proposal by signature

*External function that accepts EIP-712 signatures for voting on proposals.*


```solidity
function castVoteBySig(uint256 proposalId, uint8 support, uint8 v, bytes32 r, bytes32 s) external;
```

### castVoteWithReason

Cast a vote for a proposal with a reason


```solidity
function castVoteWithReason(uint256 proposalId, uint8 support, string calldata reason) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The id of the proposal to vote on|
|`support`|`uint8`|The support value for the vote. 0=against, 1=for, 2=abstain|
|`reason`|`string`|The reason given for the vote by the voter|


### castVoteWithReasonBySig

Cast a vote for a proposal with a reason by `ERC712` signature


```solidity
function castVoteWithReasonBySig(
    uint256 proposalId,
    uint8 support,
    string calldata reason,
    uint8 v,
    bytes32 r,
    bytes32 s
) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposalId`|`uint256`|The id of the proposal to vote on|
|`support`|`uint8`|The support value for the vote. 0=against, 1=for, 2=abstain|
|`reason`|`string`|The reason given for the vote by the voter|
|`v`|`uint8`|The recovery byte of the signature|
|`r`|`bytes32`|Half of the ECDSA signature pair|
|`s`|`bytes32`|Half of the ECDSA signature pair|


### castVoteInternal

Internal function that caries out voting logic


```solidity
function castVoteInternal(address voter, uint256 proposalId, uint8 support) internal returns (uint96);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`voter`|`address`|The voter that is casting their vote|
|`proposalId`|`uint256`|The id of the proposal to vote on|
|`support`|`uint8`|The support value for the vote. 0=against, 1=for, 2=abstain|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint96`|The number of votes cast|


### isWhitelisted

View function which returns if an account is whitelisted


```solidity
function isWhitelisted(address account) public view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|Account to check whitelist status of|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|If the account is whitelisted|


### _setVotingDelay

Admin function for setting the voting delay


```solidity
function _setVotingDelay(uint256 newVotingDelay) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`newVotingDelay`|`uint256`|new voting delay, in blocks|


### _setVotingPeriod

Admin function for setting the voting period


```solidity
function _setVotingPeriod(uint256 newVotingPeriod) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`newVotingPeriod`|`uint256`|new voting period, in blocks|


### _setProposalThreshold

Admin function for setting the proposal threshold

*newProposalThreshold must be greater than the hardcoded min*


```solidity
function _setProposalThreshold(uint256 newProposalThreshold) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`newProposalThreshold`|`uint256`|new proposal threshold|


### _setWhitelistAccountExpiration

Admin function for setting the whitelist expiration as a timestamp for an account. Whitelist status
allows accounts to propose without meeting threshold


```solidity
function _setWhitelistAccountExpiration(address account, uint256 expiration) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|Account address to set whitelist expiration for|
|`expiration`|`uint256`|Expiration for account whitelist status as timestamp (if now < expiration, whitelisted)|


### _setWhitelistGuardian

Admin function for setting the whitelistGuardian. WhitelistGuardian can cancel proposals from whitelisted
addresses


```solidity
function _setWhitelistGuardian(address account) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|Account to set whitelistGuardian to (0x0 to remove whitelistGuardian)|


### _setProposalGuardian

Admin function for setting the proposalGuardian. ProposalGuardian can cancel all proposals.


```solidity
function _setProposalGuardian(ProposalGuardian memory newProposalGuardian) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`newProposalGuardian`|`ProposalGuardian`|The account and expiration for the new proposal guardian.|


### _initiate

Initiate the GovernorBravo contract

*Admin only. Sets initial proposal id which initiates the contract, ensuring a continuous proposal id count*


```solidity
function _initiate(address governorAlpha) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`governorAlpha`|`address`|The address for the Governor to continue the proposal id count from|


### _setPendingAdmin

Begins transfer of admin rights. The newPendingAdmin must call `_acceptAdmin` to finalize the transfer.

*Admin function to begin change of admin. The newPendingAdmin must call `_acceptAdmin` to finalize the
transfer.*


```solidity
function _setPendingAdmin(address newPendingAdmin) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`newPendingAdmin`|`address`|New pending admin.|


### _acceptAdmin

Accepts transfer of admin rights. msg.sender must be pendingAdmin

*Admin function for pending admin to accept role and update admin*


```solidity
function _acceptAdmin() external;
```

### getChainIdInternal


```solidity
function getChainIdInternal() internal view returns (uint256);
```

