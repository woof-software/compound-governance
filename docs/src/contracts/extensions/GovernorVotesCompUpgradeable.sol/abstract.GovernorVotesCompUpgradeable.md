# GovernorVotesCompUpgradeable
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/extensions/GovernorVotesCompUpgradeable.sol)

**Inherits:**
Initializable, [GovernorUpgradeable](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md)

**Author:**
[ScopeLift](https://scopelift.co)

Modified GovernorVotes contract that supports Compound's COMP token.

**Note:**
security-contact: security@compound.finance


## State Variables
### GovernorVotesCompStorageLocation

```solidity
bytes32 private constant GovernorVotesCompStorageLocation =
    0x2130f92f3b57a0ca0ff53b681825494ca70980d3b0ddffac97113db00028b600;
```


## Functions
### _getGovernorVotesCompStorage


```solidity
function _getGovernorVotesCompStorage() private pure returns (GovernorVotesCompStorage storage $);
```

### __GovernorVotesComp_init


```solidity
function __GovernorVotesComp_init(IComp _tokenAddress) internal onlyInitializing;
```

### __GovernorVotesComp_init_unchained


```solidity
function __GovernorVotesComp_init_unchained(IComp _tokenAddress) internal onlyInitializing;
```

### token

Returns the IComp token used for governance.

*This function retrieves the token address from the contract's storage.*


```solidity
function token() public view virtual returns (IComp);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`IComp`|IComp The COMP token interface used for governance voting.|


### clock

This function implements the clock interface as specified in ERC-6372.

*Returns the current clock value used for governance voting.*


```solidity
function clock() public view virtual override returns (uint48);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint48`|uint48 The current block number cast to uint48.|


### CLOCK_MODE

Returns a machine-readable description of the clock as specified in ERC-6372.

*This function provides information about the clock mode used for governance timing.*


```solidity
function CLOCK_MODE() public view virtual override returns (string memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`string`|string A string describing the clock mode, indicating that block numbers are used as the time measure, with the default starting point.|


### _getVotes

Retrieves the voting weight for a specific account at a given timepoint.

*This function overrides the base _getVotes function to use Compound's getPriorVotes mechanism.*


```solidity
function _getVotes(address _account, uint256 _timepoint, bytes memory)
    internal
    view
    virtual
    override
    returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_account`|`address`|The address of the account to check the voting weight for.|
|`_timepoint`|`uint256`|The timepoint at which to check the voting weight.|
|`<none>`|`bytes`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|uint256 The voting weight of the account at the specified timepoint.|


## Structs
### GovernorVotesCompStorage
**Note:**
storage-location: erc7201:storage.GovernorVotesComp


```solidity
struct GovernorVotesCompStorage {
    IComp _token;
}
```

