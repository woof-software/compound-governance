# GovernorSequentialProposalIdUpgradeable
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol)

**Inherits:**
[GovernorUpgradeable](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md)

**Author:**
[ScopeLift](https://scopelift.co)

Extension for Governor contract that assigns sequential proposal IDs.

This abstract contract modifies GovernorStorageUpgradeable and extends GovernorUpgradeable to provide
sequential proposal IDs while preserving standard proposal addressability.

**Note:**
security-contact: security@compound.finance


## State Variables
### GovernorSequentialProposalIdStorageLocation

```solidity
bytes32 private constant GovernorSequentialProposalIdStorageLocation =
    0x357e1d0c89980520b3654c57f444238d75a15e5f41d389a090caabe54617d800;
```


## Functions
### _getGovernorSequentialProposalIdStorage


```solidity
function _getGovernorSequentialProposalIdStorage()
    private
    pure
    returns (GovernorSequentialProposalIdStorage storage $);
```

### __GovernorSequentialProposalId_init


```solidity
function __GovernorSequentialProposalId_init() internal onlyInitializing;
```

### __GovernorSequentialProposalId_init_unchained


```solidity
function __GovernorSequentialProposalId_init_unchained() internal onlyInitializing;
```

### hashProposal


```solidity
function hashProposal(
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    bytes32 _descriptionHash
) public virtual override returns (uint256);
```

### getNextProposalId


```solidity
function getNextProposalId() public view returns (uint256);
```

### _setNextProposalId


```solidity
function _setNextProposalId(uint256 _proposalId) internal virtual;
```

### _propose


```solidity
function _propose(
    address[] memory _targets,
    uint256[] memory _values,
    bytes[] memory _calldatas,
    string memory _description,
    address _proposer
) internal virtual override returns (uint256);
```

### queue

Version of [IGovernor-queue](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#queue) with only enumerated `proposalId` as an argument.

*Uses the externally-used enumerated proposal ID to find the proposal details
needed by the GovernorUpgradeable queue function.*


```solidity
function queue(uint256 _proposalId) public virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The enumerated proposal ID.|


### execute

Version of [IGovernor-execute](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#execute) with only enumerated `proposalId` as an argument.

*Uses the externally-used enumerated proposal ID to find the proposal details
needed by the GovernorUpgradeable execute function.*


```solidity
function execute(uint256 _proposalId) public payable virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The enumerated proposal ID.|


### cancel

Version of [IGovernor-cancel](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#cancel) with only enumerated `proposalId` as an argument.

*Uses the externally-used enumerated proposal ID to find the proposal details
needed by the GovernorUpgradeable cancel function.*


```solidity
function cancel(uint256 _proposalId) public virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The enumerated proposal ID.|


### proposalDetails

Returns the details of a proposalId. Reverts if `proposalId` is not a known proposal.


```solidity
function proposalDetails(uint256 _proposalId)
    public
    view
    virtual
    returns (address[] memory, uint256[] memory, bytes[] memory, bytes32);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_proposalId`|`uint256`|The enumerated proposal ID.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address[]`|The targets, values, calldatas, and descriptionHash of the proposal.|
|`<none>`|`uint256[]`||
|`<none>`|`bytes[]`||
|`<none>`|`bytes32`||


### proposalCount

Returns the number of stored proposals.


```solidity
function proposalCount() public view virtual returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The number of stored proposals.|


## Errors
### ProposalIdAlreadySet

```solidity
error ProposalIdAlreadySet();
```

## Structs
### ProposalDetails
*Storage structure to store proposal details.*


```solidity
struct ProposalDetails {
    address[] targets;
    uint256[] values;
    bytes[] calldatas;
    bytes32 descriptionHash;
}
```

### GovernorSequentialProposalIdStorage
**Note:**
storage-location: erc7201:storage.GovernorSequentialProposalIdStorage


```solidity
struct GovernorSequentialProposalIdStorage {
    uint256 _nextProposalId;
    mapping(uint256 proposalHash => uint256 proposalId) _proposalIds;
    mapping(uint256 proposalId => ProposalDetails) _proposalDetails;
}
```

