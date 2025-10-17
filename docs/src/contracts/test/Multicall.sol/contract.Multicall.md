# Multicall
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/test/Multicall.sol)

**Authors:**
Michael Elliot <mike@makerdao.com>, Joshua Levine <joshua@makerdao.com>, Nick Johnson <arachnid@notdot.net>


## Functions
### aggregate


```solidity
function aggregate(Call[] memory calls) public returns (uint256 blockNumber, bytes[] memory returnData);
```

## Structs
### Call

```solidity
struct Call {
    address target;
    bytes callData;
}
```

