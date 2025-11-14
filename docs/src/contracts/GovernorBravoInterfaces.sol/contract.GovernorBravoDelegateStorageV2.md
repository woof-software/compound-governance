# GovernorBravoDelegateStorageV2
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/GovernorBravoInterfaces.sol)

**Inherits:**
[GovernorBravoDelegateStorageV1](/contracts/GovernorBravoInterfaces.sol/contract.GovernorBravoDelegateStorageV1.md)


## State Variables
### whitelistAccountExpirations
Stores the expiration of account whitelist status as a timestamp


```solidity
mapping(address => uint256) public whitelistAccountExpirations;
```


### whitelistGuardian
Address which manages whitelisted proposals and whitelist accounts


```solidity
address public whitelistGuardian;
```


