# Changelog

All notable changes to the Compound Governance contracts are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [V2.1] - CompoundGovernor.sol:CompoundGovernor

### Added

- **Allowed Proposers System**: New system for managing a whitelist of addresses that can create proposals

  - `allowedProposers` set using `EnumerableSet` for efficient management
  - `addProposer()` and `removeProposer()` functions for managing the allowlist
  - `getAllowedProposers()` and `isAllowedProposer()` view functions
  - Minimum of 5 proposers must be maintained (`MIN_PROPOSERS = 5`)

- **Batch Whitelist Functionality**: `batchWhitelist()` function for initializing allowed proposers

  - Can only be called by the proxy admin during reinitialization
  - Validates minimum proposer count and prevents duplicates
  - First address must be the proposal guardian

- **Enhanced Proposal Validation**:

  - Proposals now check against both allowed proposers list and temporary whitelist
  - Enhanced validation when proposal guardian has expired

- **Proposal Threshold Changes**:

  - **Removed proposal threshold check** from the `propose()` function
  - Allowed proposers and whitelisted accounts can now propose regardless of voting power
  - Simplified proposal creation logic by removing `proposalThreshold()` validation
  - This change allows for more flexible governance where proposal rights are managed through the allowed proposers system rather than token holdings

- **Proxy Admin Integration**:

  - `PROXY_ADMIN` constant for upgrade management
  - `OnlyProxyAdmin()` error for access control

- **Temporary Proposer Management**:

  - `MAX_TEMPORARY_PROPOSER_LIFETIME` constant (365 days)
  - Enhanced proposer validation logic

- **Proposal Guardian Management**:
  - `setProposalGuardian()` function for updating proposal guardian with expiration
  - `ProposalGuardian` struct containing address and expiration timestamp
  - `SET_PROPOSAL_GUARDIAN_SELECTOR` constant for function identification
  - `isProposalGuardianExpired()` function to check guardian status
  - Enhanced proposal validation when guardian has expired
  - When proposal guardian expires, only `setProposalGuardian` proposals are allowed
  - Automatic management of proposal guardian in allowed proposers list
  - `_isValidProposalWhenGuardianExpired()` validation for restricted proposal types

### Changed

- **Author Attribution**: Updated from ScopeLift to WOOF! Software
- **Security Contact**: Updated to `dmitriy@woof.software`
- **Enhanced Error Handling**: New custom errors for better gas efficiency and clarity
- **Proposal Creation Logic**: Enhanced `propose()` function with additional validation layers

### Technical Details

- **Solidity Version**: 0.8.26
- **New Dependencies**: `EnumerableSet` from OpenZeppelin for efficient set management
- **Storage Layout**: Added new storage variables for allowed proposers management
- **Access Control**: Enhanced with proxy admin integration and minimum proposer requirements

---

## [V2] - CompoundGovernor.sol:CompoundGovernor

### Added

- **OpenZeppelin Governor Framework**: Complete migration to OpenZeppelin's upgradeable Governor system
- **Fractional Voting**: Support for fractional vote counting via `GovernorCountingFractionalUpgradeable`
- **Sequential Proposal IDs**: Ensures continuous proposal ID sequence via `GovernorSequentialProposalIdUpgradeable`
- **Fixed Quorum Settings**: Configurable quorum via `GovernorSettableFixedQuorumUpgradeable`
- **Late Quorum Prevention**: Automatic vote extension mechanism via `GovernorPreventLateQuorumUpgradeable`
- **Compound Timelock Integration**: Specialized timelock integration via `GovernorTimelockCompoundUpgradeable`
- **Whitelist System**: Account whitelisting with expiration timestamps
- **Proposal Guardian System**: Time-limited proposal cancellation capabilities
- **Governor Bravo Migration**: `setNextProposalId()` function for seamless migration from Governor Bravo

### Changed

- **Architecture**: Complete rewrite using OpenZeppelin's modular Governor system
- **Upgradeability**: Full upgradeable contract support with `Initializable`
- **Voting Mechanism**: Enhanced voting system with fractional support
- **Proposal Management**: Improved proposal lifecycle management

### Technical Details

- **Solidity Version**: 0.8.26
- **Author**: ScopeLift
- **Security Contact**: security@compound.finance
- **Dependencies**: Multiple OpenZeppelin Governor extensions
- **Migration Support**: Direct integration with existing Governor Bravo system

---

## [V1] - GovernorBravoDelegate.sol:GovernorBravoDelegate

### Features

- **Legacy Governance System**: Original Compound governance implementation
- **Basic Proposal System**: Standard proposal creation, voting, and execution
- **Whitelist Support**: Basic account whitelisting functionality
- **Proposal Guardian**: Time-limited proposal cancellation system
- **EIP-712 Support**: Signature-based voting support
- **Timelock Integration**: Integration with Compound's timelock system

### Technical Details

- **Solidity Version**: ^0.8.10
- **Author**: Compound Finance
- **Security Contact**: security@compound.finance
- **Architecture**: Traditional delegate pattern with storage separation
- **Voting**: Simple majority voting system
- **Quorum**: Fixed 400,000 COMP (4% of total supply)

### Limitations

- **No Upgradeability**: Cannot be upgraded once deployed
- **Fixed Quorum**: Quorum cannot be adjusted
- **No Fractional Voting**: Binary voting only
- **Limited Flexibility**: Hard-coded governance parameters

---

## Migration Path

### V1 → V2

- **Migration Method**: Complete replacement with new upgradeable system
- **Proposal ID Continuity**: Maintained through `setNextProposalId()` function
- **Parameter Migration**: Governance parameters can be reconfigured during initialization
- **Timelock Compatibility**: Maintains compatibility with existing timelock system

### V2 → V2.1

- **Migration Method**: Upgradeable proxy pattern
- **New Features**: Allowed proposers system and enhanced validation
- **Backward Compatibility**: All V2 features remain functional
- **Initialization**: `batchWhitelist()` function for setting up allowed proposers

---

## Security Considerations

### V2.1 Enhancements

- **Access Control**: Enhanced with proxy admin integration
- **Proposer Management**: Minimum proposer requirements prevent governance deadlock
- **Validation**: Multiple layers of proposal validation
- **Error Handling**: Custom errors for better gas efficiency and clarity

### V2 Improvements

- **Modular Design**: OpenZeppelin's battle-tested Governor framework
- **Upgradeability**: Ability to fix bugs and add features
- **Fractional Voting**: More nuanced voting mechanisms
- **Late Quorum Prevention**: Prevents last-minute manipulation

### V1 Legacy

- **Battle Tested**: Proven in production for years
- **Simple**: Straightforward implementation
- **Immutable**: Cannot be changed once deployed
- **Limited**: Lacks modern governance features

---

## Development Notes

- **Testing**: Comprehensive test suites for all versions
- **Documentation**: Extensive inline documentation and NatSpec comments
- **Auditing**: Regular security audits and code reviews
- **Community**: Open source development with community contributions

For more information about specific features and implementation details, refer to the individual contract files and their documentation.
