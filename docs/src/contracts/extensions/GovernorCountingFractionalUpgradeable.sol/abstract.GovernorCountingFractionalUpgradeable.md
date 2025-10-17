# GovernorCountingFractionalUpgradeable
[Git Source](https://github.com/woof-software/compound-governance/blob/c11c1f171333a62ec14d59f19bba7db61c5df459/contracts/extensions/GovernorCountingFractionalUpgradeable.sol)

**Inherits:**
Initializable, [GovernorUpgradeable](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md)

*Extension of {Governor} for fractional voting.
Similar to {GovernorCountingSimple}, this contract is a votes counting module for {Governor} that supports 3 options:
Against, For, Abstain. Additionally, it includes a fourth option: Fractional, which allows voters to split their voting
power amongst the other 3 options.
Votes cast with the Fractional support must be accompanied by a `params` argument that is three packed `uint128` values
representing the weight the delegate assigns to Against, For, and Abstain respectively. For those votes cast for the other
3 options, the `params` argument must be empty.
This is mostly useful when the delegate is a contract that implements its own rules for voting. These delegate-contracts
can cast fractional votes according to the preferences of multiple entities delegating their voting power.
Some example use cases include:
Voting from tokens that are held by a DeFi pool
Voting from an L2 with tokens held by a bridge
Voting privately from a shielded pool using zero knowledge proofs.
Based on ScopeLift's GovernorCountingFractional[https://github.com/ScopeLift/flexible-voting/blob/e5de2efd1368387b840931f19f3c184c85842761/src/GovernorCountingFractional.sol]
_Available since v5.1._*


## State Variables
### VOTE_TYPE_FRACTIONAL

```solidity
uint8 internal constant VOTE_TYPE_FRACTIONAL = 255;
```


### GovernorCountingFractionalStorageLocation

```solidity
bytes32 private constant GovernorCountingFractionalStorageLocation =
    0xd073797d8f9d07d835a3fc13195afeafd2f137da609f97a44f7a3aa434170800;
```


## Functions
### _getGovernorCountingFractionalStorage


```solidity
function _getGovernorCountingFractionalStorage() private pure returns (GovernorCountingFractionalStorage storage $);
```

### __GovernorCountingFractional_init


```solidity
function __GovernorCountingFractional_init() internal onlyInitializing;
```

### __GovernorCountingFractional_init_unchained


```solidity
function __GovernorCountingFractional_init_unchained() internal onlyInitializing;
```

### COUNTING_MODE

*See [IGovernor-COUNTING_MODE](/contracts/extensions/IGovernor.sol/interface.IGovernor.md#counting_mode).*


```solidity
function COUNTING_MODE() public pure virtual override returns (string memory);
```

### hasVoted

*See [IGovernor-hasVoted](/contracts/extensions/IGovernor.sol/interface.IGovernor.md#hasvoted).*


```solidity
function hasVoted(uint256 proposalId, address account) public view virtual override returns (bool);
```

### usedVotes

*Get the number of votes already cast by `account` for a proposal with `proposalId`. Useful for
integrations that allow delegates to cast rolling, partial votes.*


```solidity
function usedVotes(uint256 proposalId, address account) public view virtual returns (uint256);
```

### proposalVotes

*Get current distribution of votes for a given proposal.*


```solidity
function proposalVotes(uint256 proposalId)
    public
    view
    virtual
    returns (uint256 againstVotes, uint256 forVotes, uint256 abstainVotes);
```

### _quorumReached

*See [Governor-_quorumReached](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#_quorumreached).*


```solidity
function _quorumReached(uint256 proposalId) internal view virtual override returns (bool);
```

### _voteSucceeded

*See [Governor-_voteSucceeded](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#_votesucceeded). In this module, forVotes must be > againstVotes.*


```solidity
function _voteSucceeded(uint256 proposalId) internal view virtual override returns (bool);
```

### _countVote

*See [Governor-_countVote](/contracts/extensions/GovernorUpgradeable.sol/abstract.GovernorUpgradeable.md#_countvote). Function that records the delegate's votes.
Executing this function consumes (part of) the delegate's weight on the proposal. This weight can be
distributed amongst the 3 options (Against, For, Abstain) by specifying a fractional `support`.
This counting module supports two vote casting modes: nominal and fractional.
- Nominal: A nominal vote is cast by setting `support` to one of the 3 bravo options (Against, For, Abstain).
- Fractional: A fractional vote is cast by setting `support` to `type(uint8).max` (255).
Casting a nominal vote requires `params` to be empty and consumes the delegate's full remaining weight on the
proposal for the specified `support` option. This is similar to the {GovernorCountingSimple} module and follows
the `VoteType` enum from Governor Bravo. As a consequence, no vote weight remains unspent so no further voting
is possible (for this `proposalId` and this `account`).
Casting a fractional vote consumes a fraction of the delegate's remaining weight on the proposal according to the
weights the delegate assigns to each support option (Against, For, Abstain respectively). The sum total of the
three decoded vote weights _must_ be less than or equal to the delegate's remaining weight on the proposal (i.e.
their checkpointed total weight minus votes already cast on the proposal). This format can be produced using:
`abi.encodePacked(uint128(againstVotes), uint128(forVotes), uint128(abstainVotes))`
NOTE: Consider that fractional voting restricts the number of casted vote (in each category) to 128 bits.
Depending on how many decimals the underlying token has, a single voter may require to split their vote into
multiple vote operations. For precision higher than ~30 decimals, large token holders may require an
potentially large number of calls to cast all their votes. The voter has the possibility to cast all the
remaining votes in a single operation using the traditional "bravo" vote.*


```solidity
function _countVote(uint256 proposalId, address account, uint8 support, uint256 totalWeight, bytes memory params)
    internal
    virtual
    override
    returns (uint256);
```

## Errors
### GovernorExceedRemainingWeight
*A fractional vote params uses more votes than are available for that user.*


```solidity
error GovernorExceedRemainingWeight(address voter, uint256 usedVotes, uint256 remainingWeight);
```

## Structs
### ProposalVote

```solidity
struct ProposalVote {
    uint256 againstVotes;
    uint256 forVotes;
    uint256 abstainVotes;
    mapping(address voter => uint256) usedVotes;
}
```

### GovernorCountingFractionalStorage
**Note:**
storage-location: erc7201:openzeppelin.storage.GovernorCountingFractional


```solidity
struct GovernorCountingFractionalStorage {
    mapping(uint256 proposalId => ProposalVote) _proposalVotes;
}
```

