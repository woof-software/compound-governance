# Timelock
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/Timelock.sol)


## State Variables
### GRACE_PERIOD

```solidity
uint256 public constant GRACE_PERIOD = 14 days;
```


### MINIMUM_DELAY

```solidity
uint256 public constant MINIMUM_DELAY = 2 days;
```


### MAXIMUM_DELAY

```solidity
uint256 public constant MAXIMUM_DELAY = 30 days;
```


### admin

```solidity
address public admin;
```


### pendingAdmin

```solidity
address public pendingAdmin;
```


### delay

```solidity
uint256 public delay;
```


### queuedTransactions

```solidity
mapping(bytes32 => bool) public queuedTransactions;
```


## Functions
### constructor


```solidity
constructor(address admin_, uint256 delay_) public;
```

### fallback


```solidity
fallback() external payable;
```

### setDelay


```solidity
function setDelay(uint256 delay_) public;
```

### acceptAdmin


```solidity
function acceptAdmin() public;
```

### setPendingAdmin


```solidity
function setPendingAdmin(address pendingAdmin_) public;
```

### queueTransaction


```solidity
function queueTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 eta)
    public
    returns (bytes32);
```

### cancelTransaction


```solidity
function cancelTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 eta)
    public;
```

### executeTransaction


```solidity
function executeTransaction(address target, uint256 value, string memory signature, bytes memory data, uint256 eta)
    public
    payable
    returns (bytes memory);
```

### getBlockTimestamp


```solidity
function getBlockTimestamp() internal view returns (uint256);
```

## Events
### NewAdmin

```solidity
event NewAdmin(address indexed newAdmin);
```

### NewPendingAdmin

```solidity
event NewPendingAdmin(address indexed newPendingAdmin);
```

### NewDelay

```solidity
event NewDelay(uint256 indexed newDelay);
```

### CancelTransaction

```solidity
event CancelTransaction(
    bytes32 indexed txHash, address indexed target, uint256 value, string signature, bytes data, uint256 eta
);
```

### ExecuteTransaction

```solidity
event ExecuteTransaction(
    bytes32 indexed txHash, address indexed target, uint256 value, string signature, bytes data, uint256 eta
);
```

### QueueTransaction

```solidity
event QueueTransaction(
    bytes32 indexed txHash, address indexed target, uint256 value, string signature, bytes data, uint256 eta
);
```

