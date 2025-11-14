# CompoundGovernor Contract Documentation

## Overview

The `CompoundGovernor` contract is a comprehensive governance implementation for the Compound DAO. It extends OpenZeppelin's governance contracts with additional features specific to Compound's requirements, including whitelisting mechanisms, proposal guardians, and sequential proposal IDs.

## Inherited Contracts

The `CompoundGovernor` contract inherits from the following contracts:

1. `Initializable` - Provides initialization functionality for upgradeable contracts
2. `GovernorVotesCompUpgradeable` - Handles voting with COMP token
3. `GovernorTimelockCompoundUpgradeable` - Manages timelock functionality for Compound
4. `GovernorSettingsUpgradeable` - Provides configurable governance settings
5. `GovernorCountingFractionalUpgradeable` - Implements fractional vote counting
6. `GovernorPreventLateQuorumUpgradeable` - Prevents late quorum manipulation
7. `GovernorSettableFixedQuorumUpgradeable` - Manages fixed quorum settings
8. `GovernorSequentialProposalIdUpgradeable` - Provides sequential proposal ID management

## Contract Functions

### Constructor

#### `constructor()`

- **Visibility**: Public
- **Purpose**: Prevents direct initialization of the contract implementation to ensure it can only be used through a proxy pattern. This is a critical security measure that prevents the implementation contract from being initialized directly, which could lead to state corruption, unauthorized access, or bypassing of the intended upgrade mechanism.
- **Logic**: Calls `_disableInitializers()` from OpenZeppelin's Initializable contract, which sets an internal flag that permanently prevents the `initialize` function from being called on the implementation contract. This ensures that the contract can only be properly initialized through a proxy, maintaining the upgradeable pattern's security guarantees and preventing potential vulnerabilities.

### Initialization Functions

#### `initialize(...)`

- **Visibility**: Public
- **Purpose**: Sets up the complete governance system for Compound DAO by initializing all inherited contracts with their respective parameters. This function establishes the foundational governance parameters, voting mechanisms, timelock integration, and access control systems that will govern the entire protocol.
- **Parameters**:
  - `_initialVotingDelay`: Time delay (in blocks) between proposal creation and voting start
  - `_initialVotingPeriod`: Duration (in blocks) for which voting remains active
  - `_initialProposalThreshold`: Minimum COMP token balance required to create proposals
  - `_compAddress`: Address of the COMP governance token contract
  - `_quorumVotes`: Minimum number of votes required for a proposal to pass
  - `_timelockAddress`: Address of the Compound timelock contract for delayed execution
  - `_initialVoteExtension`: Additional time (in blocks) added to voting if quorum is not met
  - `_whitelistGuardian`: Address authorized to manage temporary proposer whitelist
  - `_proposalGuardian`: Guardian with special cancellation powers and expiration time
- **Logic**:
  - Initializes the base Governor with "Compound Governor" name
  - Sets up voting parameters (delay, period, threshold)
  - Configures COMP token integration for voting power
  - Establishes timelock integration for proposal execution
  - Enables late quorum prevention mechanism
  - Sets up fixed quorum requirements
  - Initializes sequential proposal ID system
  - Configures fractional vote counting
  - Sets up whitelist and proposal guardian systems

#### `batchWhitelist(address[] calldata _initProposers)`

- **Visibility**: External
- **Purpose**: Efficiently populates the allowed proposers list during the upgrade process from GovernorBravo to CompoundGovernor. This function is designed to be called only once during the upgrade to establish the initial set of authorized proposers, ensuring a smooth transition while maintaining governance continuity.
- **Access Control**: Only callable by `PROXY_ADMIN` (0x725ED7F44F0888aeC1b7630AB1ACdced91E0591A)
- **Reinitializer**: Version 2 (can only be called once during upgrade)
- **Logic**:
  - Validates that at least `MIN_PROPOSERS` (5) addresses are provided to maintain governance security
  - Ensures the first address in the array is the current proposal guardian to maintain their special privileges
  - Iterates through all provided addresses to check for zero addresses and prevent duplicates
  - Adds each valid address to the `allowedProposers` EnumerableSet
  - Emits `ProposerAdded` event for each successfully added proposer
  - Prevents the upgrade from proceeding if validation fails, ensuring governance integrity

#### `setNextProposalId()`

- **Visibility**: External
- **Purpose**: Establishes proposal ID continuity during the upgrade from GovernorBravo to CompoundGovernor. This ensures that proposal IDs remain sequential and don't conflict between the old and new governance systems, maintaining a clear audit trail and preventing confusion about proposal numbering.
- **Access Control**: Only callable by the executor (timelock contract)
- **Logic**:
  - Queries the current proposal count from the existing GovernorBravo contract (0xc0Da02939E1441F497fd74F78cE7Decb17B66529)
  - Sets the next proposal ID to be one more than the last GovernorBravo proposal ID
  - This ensures the first CompoundGovernor proposal will have an ID that follows sequentially from the last GovernorBravo proposal
  - Can only be called once during the upgrade process to prevent ID manipulation

### Proposal Management Functions

#### `propose(...)`

- **Visibility**: Public
- **Override**: `GovernorUpgradeable`
- **Purpose**: Creates a new governance proposal with enhanced access control and validation mechanisms. This function extends the standard OpenZeppelin proposal creation with Compound-specific features including whitelist management, proposal guardian restrictions, and sequential proposal ID tracking.
- **Parameters**:
  - `_targets`: Array of contract addresses that will be called if the proposal passes
  - `_values`: Array of ETH values to be sent to each target address
  - `_calldatas`: Array of function call data for each target
  - `_description`: Human-readable description of the proposal
- **Added Logic**:
  - **Description Validation**: Checks if the proposer's description meets any specific requirements or restrictions
  - **Access Control**: Verifies the proposer is either in the allowed proposers list or has active whitelist status
  - **Guardian Expiration Check**: When the proposal guardian has expired, only allows proposals that call `setProposalGuardian` to prevent governance deadlock
  - **Sequential ID Management**: Delegates to internal `_propose` function which handles sequential proposal ID assignment and proposer tracking
  - **Security**: Prevents unauthorized proposal creation while maintaining flexibility for temporary proposers

#### `_propose(...)`

- **Visibility**: Internal
- **Override**: `GovernorUpgradeable`, `GovernorSequentialProposalIdUpgradeable`
- **Purpose**: Core internal function that handles the actual proposal creation with sequential ID management and proposer activity tracking. This function implements the business logic for proposal creation while ensuring proposers cannot spam the system with multiple active proposals.
- **Parameters**:
  - `_targets`: Array of contract addresses for proposal execution
  - `_values`: Array of ETH values for each target
  - `_calldatas`: Array of function call data for each target
  - `_description`: Human-readable proposal description
  - `_proposer`: Address of the account creating the proposal
- **Added Logic**:
  - **Active Proposal Check**: Prevents proposers from creating new proposals while they have active (Pending or Active state) proposals, reducing spam and ensuring focused governance
  - **Proposer Tracking**: Maintains a mapping of each proposer's latest proposal ID for efficient state checking
  - **Sequential ID Assignment**: Uses the sequential proposal ID system instead of hash-based IDs for better predictability and auditability
  - **State Management**: Updates the proposer's latest proposal ID after successful creation
  - **Error Handling**: Provides clear error messages when proposers attempt to create multiple active proposals

#### `cancel(...)` (with parameters)

- **Visibility**: Public
- **Override**: `GovernorUpgradeable`
- **Purpose**: Cancels an active proposal with enhanced authorization controls. This function allows either the original proposer or the proposal guardian to cancel proposals, providing flexibility for emergency situations while maintaining security.
- **Parameters**:
  - `_targets`: Array of contract addresses from the original proposal
  - `_values`: Array of ETH values from the original proposal
  - `_calldatas`: Array of function call data from the original proposal
  - `_descriptionHash`: Hash of the proposal description
- **Added Logic**:
  - **Authorization Check**: Verifies the caller is either the original proposer or the current proposal guardian
  - **Guardian Expiration**: Ensures the proposal guardian can only cancel if they haven't expired
  - **Proposal Identification**: Uses the proposal hash to identify the specific proposal to cancel
  - **Security**: Prevents unauthorized cancellation while allowing legitimate proposers and guardians to act
  - **Delegation**: Calls the internal `_cancel` function to handle the actual cancellation logic

#### `cancel(uint256 _proposalId)`

- **Visibility**: Public
- **Override**: `GovernorUpgradeable`
- **Purpose**: Provides a convenient interface to cancel proposals using just the proposal ID. This function simplifies the cancellation process by automatically retrieving all proposal details and delegating to the main cancel function.
- **Parameters**:
  - `_proposalId`: The unique identifier of the proposal to cancel
- **Logic**:
  - **Proposal Lookup**: Retrieves the complete proposal details (targets, values, calldatas, description hash) using the `proposalDetails` function
  - **Delegation**: Calls the main `cancel` function with the retrieved proposal parameters
  - **Convenience**: Eliminates the need for callers to manually provide all proposal parameters
  - **Consistency**: Ensures the same authorization and validation logic applies regardless of which cancel function is used

### Whitelist Management Functions

#### `setWhitelistAccountExpiration(address _account, uint256 _expiration)`

- **Visibility**: External
- **Purpose**: Manages temporary proposer privileges by setting expiration timestamps for whitelisted accounts. This function enables flexible governance by allowing temporary proposers to create proposals without being permanent allowed proposers, while maintaining security through time-limited access.
- **Access Control**: Only addresses in the `allowedProposers` list can call this function
- **Parameters**:
  - `_account`: The address to whitelist or update whitelist expiration for
  - `_expiration`: Timestamp when the whitelist status expires (0 for immediate expiration)
- **Added Logic**:
  - **Address Validation**: Ensures the account is not the zero address to prevent invalid whitelist entries
  - **Guardian Protection**: Prevents whitelisting the proposal guardian to maintain their special role separation
  - **Duplicate Prevention**: Prevents whitelisting addresses that are already in the allowed proposers list
  - **Lifetime Limitation**: Enforces `MAX_TEMPORARY_PROPOSER_LIFETIME` (365 days) to prevent indefinite temporary access
  - **Event Emission**: Emits `WhitelistAccountExpirationSet` event for transparency and auditability
  - **Flexibility**: Allows both setting new whitelist entries and updating existing ones

### Proposer Management Functions

#### `addProposer(address _newProposer)`

- **Visibility**: External
- **Purpose**: Expands the governance system by adding new permanent proposers to the allowed proposers list. This function provides two pathways for adding proposers: through normal governance (timelock execution) or through emergency powers (proposal guardian when below minimum).
- **Access Control**:
  - **Primary**: Executor (timelock contract) - normal governance pathway
  - **Emergency**: Proposal guardian when `allowedProposers.length() <= MIN_PROPOSERS` (5)
- **Parameters**:
  - `_newProposer`: The address to add to the allowed proposers list
- **Added Logic**:
  - **Emergency Powers**: Proposal guardian can add proposers when below minimum count, even if expired, to prevent governance deadlock
  - **Address Validation**: Ensures the new proposer is not the zero address or the proposal guardian
  - **Duplicate Prevention**: Prevents adding addresses that are already in the allowed proposers list
  - **Minimum Maintenance**: Proposal guardian can only add when below minimum to prevent abuse
  - **Event Emission**: Emits `ProposerAdded` event for transparency
  - **Security**: Maintains governance integrity while providing emergency recovery mechanisms

#### `removeProposer(address _proposer)`

- **Visibility**: External
- **Purpose**: Removes a proposer from the allowed proposers list while maintaining governance security. This function ensures that the governance system can adapt to changing circumstances while preventing the removal of too many proposers that could compromise governance functionality.
- **Access Control**: Only the executor (timelock contract) can call this function
- **Parameters**:
  - `_proposer`: The address to remove from the allowed proposers list
- **Added Logic**:
  - **Address Validation**: Ensures the proposer is not the zero address or the proposal guardian
  - **Existence Check**: Verifies the proposer is actually in the allowed proposers list before removal
  - **Minimum Protection**: Prevents removal if it would bring the total below `MIN_PROPOSERS` (5) to maintain governance security
  - **Guardian Protection**: Prevents removal of the proposal guardian to maintain their special role
  - **Event Emission**: Emits `ProposerRemoved` event for transparency and auditability
  - **Governance Safety**: Ensures governance remains functional even after proposer removal

### View Functions

#### `isWhitelisted(address _account)`

- **Visibility**: Public
- **Purpose**: Determines if an account currently has temporary proposer privileges by checking their whitelist status. This function is crucial for access control in the proposal creation process.
- **Parameters**:
  - `_account`: The address to check for whitelist status
- **Returns**: Boolean indicating if the account is currently whitelisted (expiration > current timestamp)
- **Logic**: Compares the account's whitelist expiration timestamp with the current block timestamp to determine active status

#### `getAllowedProposers()`

- **Visibility**: Public
- **Purpose**: Provides a complete list of all addresses that have permanent proposer privileges. This function enables transparency and allows external systems to understand who can create proposals.
- **Returns**: Array of addresses that are in the allowed proposers list
- **Logic**: Returns all values from the `allowedProposers` EnumerableSet, providing a snapshot of current permanent proposers

#### `isAllowedProposer(address _account)`

- **Visibility**: Public
- **Purpose**: Checks if an address has permanent proposer privileges in the governance system. This function is used for access control and validation throughout the contract.
- **Parameters**:
  - `_account`: The address to check for allowed proposer status
- **Returns**: Boolean indicating if the address is in the allowed proposers list
- **Logic**: Uses the EnumerableSet's `contains` method to efficiently check membership in the allowed proposers set

#### `isProposalGuardianExpired()`

- **Visibility**: Public
- **Purpose**: Determines if the proposal guardian's special powers have expired. This function is critical for access control and determines what types of proposals can be created.
- **Returns**: Boolean indicating if the proposal guardian has expired (current timestamp > guardian expiration)
- **Logic**: Compares the current block timestamp with the proposal guardian's expiration timestamp to determine if their special powers are still active

#### `proposalCount()`

- **Visibility**: Public
- **Override**: `GovernorSequentialProposalIdUpgradeable`
- **Purpose**: Returns the current proposal count adjusted for compatibility with GovernorBravo's indexing system. This function ensures that proposal counts remain consistent between the old and new governance systems.
- **Returns**: The total number of proposals created, adjusted for GovernorBravo compatibility
- **Added Logic**:
  - **Compatibility Adjustment**: Decrements the internal proposal count by 1 because GovernorBravo indexed proposals starting from 1
  - **Consistency**: Ensures that the proposal count matches the expected numbering scheme from the previous governance system
  - **Audit Trail**: Maintains clear tracking of proposal creation across the upgrade

### Internal Helper Functions

#### `_isValidProposalWhenGuardianExpired(address[] memory _targets, bytes[] memory _calldatas)`

- **Visibility**: Internal
- **Purpose**: Enforces strict proposal validation when the proposal guardian has expired to prevent governance deadlock. This function ensures that only proposals to set a new proposal guardian are allowed when the current guardian's powers have expired.
- **Parameters**:
  - `_targets`: Array of contract addresses for the proposal
  - `_calldatas`: Array of function call data for the proposal
- **Returns**: Boolean indicating if the proposal is valid when guardian has expired
- **Logic**:
  - **Single Call Requirement**: Ensures the proposal contains exactly one function call
  - **Self-Targeting**: Verifies the call targets this contract (CompoundGovernor)
  - **Selector Validation**: Checks that the function selector matches `setProposalGuardian` (0xb80d105a)
  - **Deadlock Prevention**: Prevents arbitrary proposals when guardian is expired, ensuring only guardian replacement is possible

#### `_setWhitelistGuardian(address _newWhitelistGuardian)`

- **Visibility**: Internal
- **Purpose**: Updates the whitelist guardian address and emits the appropriate event. This function handles the internal logic for changing the whitelist guardian, which has the power to manage temporary proposer whitelist and cancel whitelisted proposers' proposals.
- **Parameters**:
  - `_newWhitelistGuardian`: The new address to set as whitelist guardian (can be zero address to remove)
- **Logic**:
  - **State Update**: Updates the `whitelistGuardian` state variable
  - **Event Emission**: Emits `WhitelistGuardianSet` event with both old and new guardian addresses
  - **Flexibility**: Allows setting to zero address to effectively remove the whitelist guardian role

#### `_setProposalGuardian(ProposalGuardian memory _newProposalGuardian)`

- **Visibility**: Internal
- **Purpose**: Updates the proposal guardian with their address and expiration timestamp, managing their special privileges in the governance system. This function handles the complex logic of guardian transitions while maintaining governance integrity.
- **Parameters**:
  - `_newProposalGuardian`: Struct containing the new guardian's address and expiration timestamp
- **Logic**:
  - **Event Emission**: Emits `ProposalGuardianSet` event with complete transition details (old and new guardian info)
  - **Proposer Management**: When changing guardians, removes the old guardian from allowed proposers and adds the new guardian
  - **State Update**: Updates the `proposalGuardian` state variable with the new guardian information
  - **Continuity**: Ensures smooth transition of special privileges between guardians
  - **Security**: Maintains the guardian's special role in the allowed proposers list

### Admin Functions

#### `setWhitelistGuardian(address _newWhitelistGuardian)`

- **Visibility**: External
- **Purpose**: Changes the whitelist guardian through the governance process. This function allows the community to update who has the power to manage temporary proposer whitelist and cancel whitelisted proposers' proposals.
- **Access Control**: Only callable through governance process (timelock execution)
- **Parameters**:
  - `_newWhitelistGuardian`: The new address to set as whitelist guardian
- **Logic**:
  - **Governance Check**: Calls `_checkGovernance()` to ensure this is being executed through proper governance
  - **Delegation**: Calls internal `_setWhitelistGuardian` function to handle the actual state update
  - **Security**: Ensures only legitimate governance decisions can change this critical role

#### `setProposalGuardian(ProposalGuardian memory _newProposalGuardian)`

- **Visibility**: External
- **Purpose**: Updates the proposal guardian through the governance process. This function allows the community to change who has special proposal cancellation powers and emergency proposer addition capabilities.
- **Access Control**: Only callable through governance process (timelock execution)
- **Parameters**:
  - `_newProposalGuardian`: Struct containing the new guardian's address and expiration timestamp
- **Logic**:
  - **Governance Check**: Calls `_checkGovernance()` to ensure this is being executed through proper governance
  - **Delegation**: Calls internal `_setProposalGuardian` function to handle the complex guardian transition logic
  - **Security**: Ensures only legitimate governance decisions can change this critical emergency role

### Overridden Functions

#### `hashProposal(...)`

- **Override**: `GovernorUpgradeable`, `GovernorSequentialProposalIdUpgradeable`
- **Purpose**: Implements sequential proposal ID hashing instead of the default hash-based approach. This ensures that proposal IDs are predictable and sequential, making them easier to track and reference.
- **Added Logic**: Uses the sequential proposal ID system which generates IDs in order (1, 2, 3...) rather than using content hashes, providing better auditability and user experience.

#### `_cancel(...)`

- **Override**: `GovernorUpgradeable`, `GovernorTimelockCompoundUpgradeable`
- **Purpose**: Resolves function ambiguity between multiple inherited contracts by explicitly choosing the Compound timelock implementation. This ensures proper integration with Compound's specific timelock requirements.
- **Added Logic**: Delegates to `GovernorTimelockCompoundUpgradeable._cancel` to handle Compound-specific timelock cancellation logic, ensuring compatibility with Compound's governance infrastructure.

#### `_castVote(...)`

- **Override**: `GovernorUpgradeable`, `GovernorPreventLateQuorumUpgradeable`
- **Purpose**: Resolves function ambiguity by choosing the late quorum prevention implementation. This ensures that the voting system includes mechanisms to prevent late quorum manipulation.
- **Added Logic**: Uses `GovernorPreventLateQuorumUpgradeable._castVote` to implement vote casting with late quorum protection, preventing malicious actors from manipulating quorum at the last minute.

#### `_executeOperations(...)`

- **Override**: `GovernorUpgradeable`, `GovernorTimelockCompoundUpgradeable`
- **Purpose**: Resolves function ambiguity by choosing the Compound timelock execution implementation. This ensures that proposal execution follows Compound's specific timelock requirements.
- **Added Logic**: Delegates to `GovernorTimelockCompoundUpgradeable._executeOperations` to handle Compound-specific execution logic, ensuring proper integration with Compound's timelock system.

#### `_executor()`

- **Override**: `GovernorUpgradeable`, `GovernorTimelockCompoundUpgradeable`
- **Purpose**: Resolves function ambiguity by choosing the Compound timelock executor implementation. This determines which contract is responsible for executing approved proposals.
- **Added Logic**: Returns the Compound timelock contract as the executor, ensuring that all proposal execution goes through Compound's timelock mechanism for security and delay.

#### `_queueOperations(...)`

- **Override**: `GovernorUpgradeable`, `GovernorTimelockCompoundUpgradeable`
- **Purpose**: Resolves function ambiguity by choosing the Compound timelock queuing implementation. This handles the process of queuing proposals for execution after they pass.
- **Added Logic**: Uses `GovernorTimelockCompoundUpgradeable._queueOperations` to queue proposals in Compound's timelock system, ensuring proper delay and execution scheduling.

#### `proposalDeadline(uint256 _proposalId)`

- **Override**: `GovernorPreventLateQuorumUpgradeable`, `GovernorUpgradeable`
- **Purpose**: Resolves function ambiguity by choosing the late quorum prevention implementation for deadline calculation. This ensures that proposal deadlines account for late quorum prevention mechanisms.
- **Added Logic**: Uses `GovernorPreventLateQuorumUpgradeable.proposalDeadline` to calculate deadlines that include late quorum protection, preventing last-minute quorum manipulation.

#### `proposalNeedsQueuing(uint256 _proposalId)`

- **Override**: `GovernorTimelockCompoundUpgradeable`, `GovernorUpgradeable`
- **Purpose**: Resolves function ambiguity by choosing the Compound timelock implementation for queuing determination. This determines whether a proposal needs to be queued in the timelock.
- **Added Logic**: Uses `GovernorTimelockCompoundUpgradeable.proposalNeedsQueuing` to determine if proposals require timelock queuing based on Compound's specific requirements.

#### `proposalThreshold()`

- **Override**: `GovernorSettingsUpgradeable`, `GovernorUpgradeable`
- **Purpose**: Resolves function ambiguity by choosing the settings implementation for threshold calculation. This determines the minimum token balance required to create proposals.
- **Added Logic**: Uses `GovernorSettingsUpgradeable.proposalThreshold` to return the configurable proposal threshold, allowing governance to adjust the minimum requirements for proposal creation.

#### `state(uint256 _proposalId)`

- **Override**: `GovernorUpgradeable`, `GovernorTimelockCompoundUpgradeable`
- **Purpose**: Resolves function ambiguity by choosing the Compound timelock implementation for state determination. This determines the current state of a proposal considering timelock requirements.
- **Added Logic**: Uses `GovernorTimelockCompoundUpgradeable.state` to determine proposal states that account for Compound's timelock integration, ensuring accurate state reporting.

#### `COUNTING_MODE()`

- **Override**: `IGovernor`, `GovernorCountingFractionalUpgradeable`
- **Purpose**: Defines the specific vote counting mode used by this governance system. This provides transparency about how votes are counted and processed.
- **Returns**: "support=bravo,fractional&quorum=for&params=fractional"
- **Added Logic**: Specifies that the system uses Bravo-style voting (For/Against/Abstain) with fractional vote counting and quorum based only on "For" votes, providing more nuanced voting capabilities.

#### `_quorumReached(uint256 proposalId)`

- **Override**: `GovernorUpgradeable`, `GovernorCountingFractionalUpgradeable`
- **Purpose**: Implements custom quorum logic that only considers "For" votes when determining if quorum has been reached. This prevents "Against" votes from contributing to quorum, which could be used to block governance.
- **Added Logic**:
  - **For-Only Quorum**: Only counts votes in favor when checking if quorum has been reached
  - **Anti-Block Mechanism**: Prevents malicious actors from using "Against" votes to prevent quorum from being reached
  - **Fractional Support**: Works with the fractional vote counting system to provide more precise quorum calculations

## Key Features

### Whitelist System

- Accounts can be temporarily whitelisted to create proposals
- Whitelisted accounts have expiration timestamps
- Whitelist guardian can manage whitelist expirations

### Proposal Guardian System

- Proposal guardian can cancel proposals until expiration
- When guardian expires, only setProposalGuardian proposals are allowed
- Guardian is automatically added to allowed proposers

### Sequential Proposal IDs

- Proposals use sequential IDs instead of hash-based IDs
- Maintains compatibility with GovernorBravo numbering
- Prevents proposers from creating multiple active proposals

### Access Control

- Minimum number of proposers must be maintained
- Only allowed proposers or whitelisted accounts can create proposals
- Governance functions require timelock execution

## Events

- `WhitelistAccountExpirationSet`: Emitted when whitelist expiration is set
- `WhitelistGuardianSet`: Emitted when whitelist guardian changes
- `ProposalGuardianSet`: Emitted when proposal guardian changes
- `ProposerAdded`: Emitted when a proposer is added
- `ProposerRemoved`: Emitted when a proposer is removed

## Errors

The contract defines several custom errors for better gas efficiency and clearer error messages, including authorization errors, validation errors, and state-related errors.
