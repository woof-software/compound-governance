# IComp
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/interfaces/IComp.sol)


## Functions
### DELEGATION_TYPEHASH


```solidity
function DELEGATION_TYPEHASH() external view returns (bytes32);
```

### DOMAIN_TYPEHASH


```solidity
function DOMAIN_TYPEHASH() external view returns (bytes32);
```

### allowance


```solidity
function allowance(address account, address spender) external view returns (uint256);
```

### approve


```solidity
function approve(address spender, uint256 rawAmount) external returns (bool);
```

### balanceOf


```solidity
function balanceOf(address account) external view returns (uint256);
```

### checkpoints


```solidity
function checkpoints(address, uint32) external view returns (uint32 fromBlock, uint96 votes);
```

### decimals


```solidity
function decimals() external view returns (uint8);
```

### delegate


```solidity
function delegate(address delegatee) external;
```

### delegateBySig


```solidity
function delegateBySig(address delegatee, uint256 nonce, uint256 expiry, uint8 v, bytes32 r, bytes32 s) external;
```

### delegates


```solidity
function delegates(address) external view returns (address);
```

### getCurrentVotes


```solidity
function getCurrentVotes(address account) external view returns (uint96);
```

### getPriorVotes


```solidity
function getPriorVotes(address account, uint256 blockNumber) external view returns (uint96);
```

### name


```solidity
function name() external view returns (string memory);
```

### nonces


```solidity
function nonces(address) external view returns (uint256);
```

### numCheckpoints


```solidity
function numCheckpoints(address) external view returns (uint32);
```

### symbol


```solidity
function symbol() external view returns (string memory);
```

### totalSupply


```solidity
function totalSupply() external view returns (uint256);
```

### transfer


```solidity
function transfer(address dst, uint256 rawAmount) external returns (bool);
```

### transferFrom


```solidity
function transferFrom(address src, address dst, uint256 rawAmount) external returns (bool);
```

## Events
### Approval

```solidity
event Approval(address indexed owner, address indexed spender, uint256 amount);
```

### DelegateChanged

```solidity
event DelegateChanged(address indexed delegator, address indexed fromDelegate, address indexed toDelegate);
```

### DelegateVotesChanged

```solidity
event DelegateVotesChanged(address indexed delegate, uint256 previousBalance, uint256 newBalance);
```

### Transfer

```solidity
event Transfer(address indexed from, address indexed to, uint256 amount);
```

## Structs
### Checkpoint

```solidity
struct Checkpoint {
    uint32 fromBlock;
    uint96 votes;
}
```

