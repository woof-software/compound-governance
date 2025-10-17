# CompoundGovernorV2
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/CompoundGovernorV2.sol)

**Inherits:**
Initializable, [GovernorVotesCompUpgradeable](/contracts/extensions/GovernorVotesCompUpgradeable.sol/abstract.GovernorVotesCompUpgradeable.md), [GovernorTimelockCompoundUpgradeable](/contracts/extensions/GovernorTimelockCompoundUpgradeable.sol/abstract.GovernorTimelockCompoundUpgradeable.md), [GovernorSettingsUpgradeable](/contracts/extensions/GovernorSettingsUpgradeable.sol/abstract.GovernorSettingsUpgradeable.md), [GovernorCountingFractionalUpgradeable](/contracts/extensions/GovernorCountingFractionalUpgradeable.sol/abstract.GovernorCountingFractionalUpgradeable.md), [GovernorPreventLateQuorumUpgradeable](/contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol/abstract.GovernorPreventLateQuorumUpgradeable.md), [GovernorSettableFixedQuorumUpgradeable](/contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol/abstract.GovernorSettableFixedQuorumUpgradeable.md), [GovernorSequentialProposalIdUpgradeable](/contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol/abstract.GovernorSequentialProposalIdUpgradeable.md)

**Author:**
[ScopeLift](https://scopelift.co)

A governance contract for the Compound DAO.

**Note:**
security-contact: security@compound.finance


## State Variables
### compoundGovernorBravo

```solidity
GovernorAlphaInterface private constant compoundGovernorBravo =
    GovernorAlphaInterface(0xc0Da02939E1441F497fd74F78cE7Decb17B66529);
```


### whitelistGuardian
Address which manages whitelisted proposals and whitelist accounts.

*This address has the ability to set account whitelist expirations and can be changed through the governance
process.*


```solidity
address public whitelistGuardian;
```


### proposalGuardian
Account which has the ability to cancel proposals. This privilege expires at the given expiration
timestamp.


```solidity
ProposalGuardian public proposalGuardian;
```


### whitelistAccountExpirations
Stores the expiration of account whitelist status as a timestamp.


```solidity
mapping(address account => uint256 timestamp) public whitelistAccountExpirations;
```


### latestProposalIds
Stores the latest proposal ID for each proposer.


```solidity
mapping(address proposer => uint256 latestProposalId) public latestProposalIds;
```


## Functions
### constructor

Disables the initialize function.


```solidity
constructor();
```

### initialize

Initialize Governor.


```solidity
function initialize(
    uint48 _initialVotingDelay,
    uint32 _initialVotingPeriod,
    uint256 _initialProposalThreshold,
    IComp _compAddress,
    uint256 _quorumVotes,
    ICompoundTimelock _timelockAddress,
    uint48 _initialVoteExtension,
    address _whitelistGuardian,
    ProposalGuardian calldata _proposalGuardian
) public initializer;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initialVotingDelay`|`uint48`|The initial voting delay.|
|`_initialVotingPeriod`|`uint32`|The initial voting period.|
|`_initialProposalThreshold`|`uint256`|The initial proposal threshold.|
|`_compAddress`|`IComp`|The address of the Comp token.|
|`_quorumVotes`|`uint256`|The quorum votes.|
|`_timelockAddress`|`ICompoundTimelock`|The address of the Timelock.|
|`_initialVoteExtension`|`uint48`|The initial vote extension.|
|`_whitelistGuardian`|`address`|The address of the whitelist guardian.|
|`_proposalGuardian`|`ProposalGuardian`|The proposal guardian.|


### setNextProposalId

Sets the next proposal ID. Designed to be callable once by the executor (timelock) on upgrade from
Compound GovernorBravo.


```solidity
function setNextProposalId() external;
```

### proposalCount

Returns the number of stored proposals.

*Since GovernorBravo indexed from 1, we decrement the proposal count by 1.*


```solidity
function proposalCount() public view override returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The number of stored proposals.|


### hashProposal

A modified `hashProposal` that supports sequential proposal IDs.


```solidity
function hashProposal(
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    bytes32 _descriptionHash
) public virtual override(GovernorUpgradeable, GovernorSequentialProposalIdUpgradeable) returns (uint256);
```

### propose

Creates a new proposal. Skips proposal threshold check for whitelisted accounts.


```solidity
function propose(
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    string memory _description
) public override(GovernorUpgradeable) returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_targets`|`address[]`|An array of addresses that will be called if the proposal is executed.|
|`_values`|`uint256[]`|An array of ETH values to be sent to each address when the proposal is executed.|
|`_calldatas`|`bytes[]`|An array of calldata to be sent to each address when the proposal is executed.|
|`_description`|`string`|A human-readable description of the proposal.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|uint256 The ID of the newly created proposal.|


### _propose

Internal function used to create a new proposal.

*This is an override that supports sequential proposal IDs. Called by the public `propose` function.*


```solidity
function _propose(
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    string memory _description,
    address _proposer
) internal override(GovernorUpgradeable, GovernorSequentialProposalIdUpgradeable) returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_targets`|`address[]`|An array of addresses that will be called if the proposal is executed.|
|`_values`|`uint256[]`|An array of ETH values to be sent to each address when the proposal is executed.|
|`_calldatas`|`bytes[]`|An array of calldata to be sent to each address when the proposal is executed.|
|`_description`|`string`|A human-readable description of the proposal.|
|`_proposer`|`address`|The address of the account creating the proposal.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|uint256 The ID of the newly created proposal.|


### cancel

Cancels an active proposal.

This function can be called by the proposer, the proposal guardian, or anyone if the proposer's voting
power has dropped below the proposal threshold. For whitelisted proposers, only special actors (proposer,
proposal guardian, whitelist guardian) can cancel if the proposer is below the threshold.


```solidity
function cancel(
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    bytes32 _descriptionHash
) public override returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_targets`|`address[]`|An array of addresses that will be called if the proposal is executed.|
|`_values`|`uint256[]`|An array of ETH values to be sent to each address when the proposal is executed.|
|`_calldatas`|`bytes[]`|An array of calldata to be sent to each address when the proposal is executed.|
|`_descriptionHash`|`bytes32`|The hash of the proposal's description string.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|uint256 The ID of the canceled proposal.|


### cancel

Cancels a proposal given its ID.

This function can be called by the proposer, the proposal guardian, or anyone if the proposer's voting
power has dropped below the proposal threshold. For whitelisted proposers, only special actors (proposer,
proposal guardian, whitelist guardian) can cancel if the proposer is below the threshold.

*This function retrieves proposal details and calls the main cancel function with those details.*


```solidity
function cancel(uint256 _proposalId) public override;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The ID of the proposal to cancel.|


### setWhitelistAccountExpiration

Sets or updates the whitelist expiration for a specific account.
A whitelisted account can create proposals without meeting the 'proposalThreshold'.
A whitelisted account's proposals cannot be canceled by anyone except the `whitelistGuardian` and only when its
voting weight is below the `proposalThreshold`.
A whitelisted account and `proposalGuardian` can still cancel its proposals regardless of voting weight.

*Only the executor (timelock) or the `whitelistGuardian` can call this function.*


```solidity
function setWhitelistAccountExpiration(address _account, uint256 _expiration) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_account`|`address`|The address of the account to be whitelisted.|
|`_expiration`|`uint256`|The timestamp until which the account will be whitelisted.|


### isWhitelisted

Checks if an account is currently whitelisted.

Only a `whitelistGuardian` can cancel a whitelisted account's proposal for falling below
`proposalThreshold`.

The proposer and proposalGuardian can still cancel a whitelisted account's proposal regardless of voting
weight.


```solidity
function isWhitelisted(address _account) public view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_account`|`address`|The address of the account to check.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|bool Returns true if the account is whitelisted (expiration is in the future), false otherwise.|


### setWhitelistGuardian

Sets a new `whitelistGuardian`.

a `whitelistGuardian` can whitelist accounts and can cancel whitelisted accounts' proposals when they
fall.
below `proposalThreshold.

*Only the executor (timelock) can call this function.*


```solidity
function setWhitelistGuardian(address _newWhitelistGuardian) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_newWhitelistGuardian`|`address`|The address of the new `whitelistGuardian`.|


### setProposalGuardian

Sets a new proposal guardian.

*This function can only be called by the executor (timelock).*


```solidity
function setProposalGuardian(ProposalGuardian memory _newProposalGuardian) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_newProposalGuardian`|`ProposalGuardian`|The new proposal guardian to be set, including their address and expiration.|


### _setWhitelistGuardian

Admin function for setting the whitelistGuardian. WhitelistGuardian can cancel proposals from
whitelisted addresses.


```solidity
function _setWhitelistGuardian(address _newWhitelistGuardian) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_newWhitelistGuardian`|`address`|Account to set whitelistGuardian to (0x0 to remove whitelistGuardian).|


### _setProposalGuardian

Internal function to set a new proposal guardian.

*This function updates the proposal guardian and emits an event.*


```solidity
function _setProposalGuardian(ProposalGuardian memory _newProposalGuardian) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_newProposalGuardian`|`ProposalGuardian`|The new proposal guardian to be set, including their address and expiration.|


### _cancel

*We override this function to resolve ambiguity between inherited contracts.*


```solidity
function _cancel(
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    bytes32 _descriptionHash
) internal override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable) returns (uint256);
```

### _castVote

*We override this function to resolve ambiguity between inherited contracts.*


```solidity
function _castVote(uint256 _proposalId, address _account, uint8 _support, string memory _reason, bytes memory _params)
    internal
    override(GovernorUpgradeable, GovernorPreventLateQuorumUpgradeable)
    returns (uint256);
```

### _executeOperations

*We override this function to resolve ambiguity between inherited contracts.*


```solidity
function _executeOperations(
    uint256 _proposalId,
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    bytes32 _descriptionHash
) internal override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable);
```

### _executor

*Address through which the governor executes action. In this case, the timelock.*


```solidity
function _executor()
    internal
    view
    override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable)
    returns (address);
```

### _queueOperations

*We override this function to resolve ambiguity between inherited contracts.*


```solidity
function _queueOperations(
    uint256 _proposalId,
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    bytes32 _descriptionHash
) internal override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable) returns (uint48);
```

### proposalDeadline

*We override this function to resolve ambiguity between inherited contracts.*


```solidity
function proposalDeadline(uint256 _proposalId)
    public
    view
    override(GovernorPreventLateQuorumUpgradeable, GovernorUpgradeable)
    returns (uint256);
```

### proposalNeedsQueuing

*We override this function to resolve ambiguity between inherited contracts.*


```solidity
function proposalNeedsQueuing(uint256 _proposalId)
    public
    view
    override(GovernorTimelockCompoundUpgradeable, GovernorUpgradeable)
    returns (bool);
```

### proposalThreshold

*We override this function to resolve ambiguity between inherited contracts.*


```solidity
function proposalThreshold() public view override(GovernorSettingsUpgradeable, GovernorUpgradeable) returns (uint256);
```

### state

*We override this function to resolve ambiguity between inherited contracts.*


```solidity
function state(uint256 _proposalId)
    public
    view
    override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable)
    returns (ProposalState);
```

### COUNTING_MODE

*See {IGovernor-COUNTING_MODE}.*


```solidity
function COUNTING_MODE()
    public
    pure
    override(IGovernor, GovernorCountingFractionalUpgradeable)
    returns (string memory);
```

### _quorumReached

Internal function that returns true if the amount of 'for' votes already cast meets the quorum limit,
false otherwise.

*We override this function to implement quorum functionality that only includes votes in favor.*


```solidity
function _quorumReached(uint256 proposalId)
    internal
    view
    override(GovernorUpgradeable, GovernorCountingFractionalUpgradeable)
    returns (bool);
```

## Events
### WhitelistAccountExpirationSet
Emitted when the expiration of a whitelisted account is set or updated.


```solidity
event WhitelistAccountExpirationSet(address account, uint256 expiration);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address of the account being whitelisted.|
|`expiration`|`uint256`|The timestamp until which the account is whitelisted.|

### WhitelistGuardianSet
Emitted when the whitelistGuardian is set or changed.


```solidity
event WhitelistGuardianSet(address oldGuardian, address newGuardian);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`oldGuardian`|`address`|The address of the previous whitelistGuardian.|
|`newGuardian`|`address`|The address of the new whitelistGuardian.|

### ProposalGuardianSet
Emitted when the proposal guardian is set or updated.


```solidity
event ProposalGuardianSet(
    address oldProposalGuardian,
    uint96 oldProposalGuardianExpiry,
    address newProposalGuardian,
    uint96 newProposalGuardianExpiry
);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`oldProposalGuardian`|`address`|The address of the previous proposal guardian.|
|`oldProposalGuardianExpiry`|`uint96`|The expiration timestamp of the previous proposal guardian's role.|
|`newProposalGuardian`|`address`|The address of the new proposal guardian.|
|`newProposalGuardianExpiry`|`uint96`|The expiration timestamp of the new proposal guardian's role.|

## Errors
### Unauthorized
Error thrown when an unauthorized address attempts to perform a restricted action.


```solidity
error Unauthorized(bytes32 reason, address caller);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`reason`|`bytes32`|A brief description of why the caller is unauthorized.|
|`caller`|`address`|The address that attempted the unauthorized action.|

### ProposerActiveProposal
Error thrown when a proposer attempts to create a new proposal while they have an active proposal.


```solidity
error ProposerActiveProposal(address proposer, uint256 proposalId, ProposalState state);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`proposer`|`address`|The address of the proposer.|
|`proposalId`|`uint256`|The ID of the active proposal.|
|`state`|`ProposalState`|The state of the active proposal.|

## Structs
### ProposalGuardian
The address and expiration of the proposal guardian.


```solidity
struct ProposalGuardian {
    address account;
    uint96 expiration;
}
```

