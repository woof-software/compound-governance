# GovernorSettableFixedQuorumUpgradeable
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol)

**Inherits:**
Initializable, [GovernorUpgradeable](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md)

**Author:**
[ScopeLift](https://scopelift.co)

An abstract extension to the Governor which implements a fixed quorum which can be updated by governance.

**Note:**
security-contact: security@compound.finance


## State Variables
### GovernorSettableFixedQuorumStorageLocation

```solidity
bytes32 private constant GovernorSettableFixedQuorumStorageLocation =
    0xfc13b0622f15c0c6558fbb10a1f5d36853f903c871b669bae7001d348b50ca00;
```


## Functions
### _getGovernorSettableFixedQuorumStorage


```solidity
function _getGovernorSettableFixedQuorumStorage() private pure returns (GovernorSettableFixedQuorumStorage storage $);
```

### __GovernorSettableFixedQuorum_init


```solidity
function __GovernorSettableFixedQuorum_init(uint256 _initialQuorum) internal onlyInitializing;
```

### __GovernorSettableFixedQuorum_init_unchained


```solidity
function __GovernorSettableFixedQuorum_init_unchained(uint256 _initialQuorum) internal onlyInitializing;
```

### setQuorum

A function to set quorum for the current timepoint. Proposals created after this timepoint will be
subject to the new quorum.


```solidity
function setQuorum(uint256 _amount) external virtual onlyGovernance;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amount`|`uint256`|The new quorum threshold.|


### quorum

A function to get the quorum threshold for a given timepoint.


```solidity
function quorum(uint256 _voteStart) public view virtual override returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_voteStart`|`uint256`|The vote start timepoint for a given proposal.|


### _setQuorum

A function to set quorum for the current timepoint.


```solidity
function _setQuorum(uint256 _amount) internal virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amount`|`uint256`|The quorum amount to checkpoint.|


## Events
### QuorumUpdated
Emitted when the quorum value has changed.


```solidity
event QuorumUpdated(uint256 oldQuorum, uint256 newQuorum);
```

## Structs
### GovernorSettableFixedQuorumStorage
**Note:**
storage-location: erc7201:storage.GovernorSettableFixedQuorum


```solidity
struct GovernorSettableFixedQuorumStorage {
    Checkpoints.Trace208 _quorumCheckpoints;
}
```

