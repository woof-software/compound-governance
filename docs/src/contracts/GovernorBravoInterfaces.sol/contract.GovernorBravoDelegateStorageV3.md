# GovernorBravoDelegateStorageV3
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/GovernorBravoInterfaces.sol)

**Inherits:**
[GovernorBravoDelegateStorageV2](/contracts/GovernorBravoInterfaces.sol/contract.GovernorBravoDelegateStorageV2.md)


## State Variables
### proposalGuardian
Account which has the ability to cancel proposals. This privilege expires at the given expiration timestamp.


```solidity
ProposalGuardian public proposalGuardian;
```


## Structs
### ProposalGuardian
The address and expiration of the proposal guardian.


```solidity
struct ProposalGuardian {
    address account;
    uint96 expiration;
}
```

