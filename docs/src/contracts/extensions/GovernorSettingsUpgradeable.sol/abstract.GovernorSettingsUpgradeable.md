# GovernorSettingsUpgradeable
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/extensions/GovernorSettingsUpgradeable.sol)

**Inherits:**
Initializable, [GovernorUpgradeable](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md)

*Extension of {Governor} for settings updatable through governance.*


## State Variables
### GovernorSettingsStorageLocation

```solidity
bytes32 private constant GovernorSettingsStorageLocation =
    0x00d7616c8fe29c6c2fbe1d0c5bc8f2faa4c35b43746e70b24b4d532752affd00;
```


## Functions
### _getGovernorSettingsStorage


```solidity
function _getGovernorSettingsStorage() private pure returns (GovernorSettingsStorage storage $);
```

### __GovernorSettings_init

*Initialize the governance parameters.*


```solidity
function __GovernorSettings_init(
    uint48 initialVotingDelay,
    uint32 initialVotingPeriod,
    uint256 initialProposalThreshold
) internal onlyInitializing;
```

### __GovernorSettings_init_unchained


```solidity
function __GovernorSettings_init_unchained(
    uint48 initialVotingDelay,
    uint32 initialVotingPeriod,
    uint256 initialProposalThreshold
) internal onlyInitializing;
```

### votingDelay

*See [IGovernor-votingDelay](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#votingdelay).*


```solidity
function votingDelay() public view virtual override returns (uint256);
```

### votingPeriod

*See [IGovernor-votingPeriod](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#votingperiod).*


```solidity
function votingPeriod() public view virtual override returns (uint256);
```

### proposalThreshold

*See [Governor-proposalThreshold](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#proposalthreshold).*


```solidity
function proposalThreshold() public view virtual override returns (uint256);
```

### setVotingDelay

*Update the voting delay. This operation can only be performed through a governance proposal.
Emits a [VotingDelaySet](/contracts/extensions/GovernorSettingsUpgradeable.sol/abstract.GovernorSettingsUpgradeable.md#votingdelayset) event.*


```solidity
function setVotingDelay(uint48 newVotingDelay) public virtual onlyGovernance;
```

### setVotingPeriod

*Update the voting period. This operation can only be performed through a governance proposal.
Emits a [VotingPeriodSet](/contracts/extensions/GovernorSettingsUpgradeable.sol/abstract.GovernorSettingsUpgradeable.md#votingperiodset) event.*


```solidity
function setVotingPeriod(uint32 newVotingPeriod) public virtual onlyGovernance;
```

### setProposalThreshold

*Update the proposal threshold. This operation can only be performed through a governance proposal.
Emits a [ProposalThresholdSet](/contracts/extensions/GovernorSettingsUpgradeable.sol/abstract.GovernorSettingsUpgradeable.md#proposalthresholdset) event.*


```solidity
function setProposalThreshold(uint256 newProposalThreshold) public virtual onlyGovernance;
```

### _setVotingDelay

*Internal setter for the voting delay.
Emits a [VotingDelaySet](/contracts/extensions/GovernorSettingsUpgradeable.sol/abstract.GovernorSettingsUpgradeable.md#votingdelayset) event.*


```solidity
function _setVotingDelay(uint48 newVotingDelay) internal virtual;
```

### _setVotingPeriod

*Internal setter for the voting period.
Emits a [VotingPeriodSet](/contracts/extensions/GovernorSettingsUpgradeable.sol/abstract.GovernorSettingsUpgradeable.md#votingperiodset) event.*


```solidity
function _setVotingPeriod(uint32 newVotingPeriod) internal virtual;
```

### _setProposalThreshold

*Internal setter for the proposal threshold.
Emits a [ProposalThresholdSet](/contracts/extensions/GovernorSettingsUpgradeable.sol/abstract.GovernorSettingsUpgradeable.md#proposalthresholdset) event.*


```solidity
function _setProposalThreshold(uint256 newProposalThreshold) internal virtual;
```

## Events
### VotingDelaySet

```solidity
event VotingDelaySet(uint256 oldVotingDelay, uint256 newVotingDelay);
```

### VotingPeriodSet

```solidity
event VotingPeriodSet(uint256 oldVotingPeriod, uint256 newVotingPeriod);
```

### ProposalThresholdSet

```solidity
event ProposalThresholdSet(uint256 oldProposalThreshold, uint256 newProposalThreshold);
```

## Structs
### GovernorSettingsStorage
**Note:**
storage-location: erc7201:openzeppelin.storage.GovernorSettings


```solidity
struct GovernorSettingsStorage {
    uint256 _proposalThreshold;
    uint48 _votingDelay;
    uint32 _votingPeriod;
}
```

