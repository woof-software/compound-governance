// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.26;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {IGovernor} from "contracts/extensions/IGovernor.sol";
import {GovernorUpgradeable} from "contracts/extensions/GovernorUpgradeable.sol";
import {GovernorSequentialProposalIdUpgradeable} from "contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol";
import {GovernorVotesCompUpgradeable} from "contracts/extensions/GovernorVotesCompUpgradeable.sol";
import {GovernorSettableFixedQuorumUpgradeable} from "contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol";
import {GovernorCountingFractionalUpgradeable} from "contracts/extensions/GovernorCountingFractionalUpgradeable.sol";
import {GovernorTimelockCompoundUpgradeable} from "contracts/extensions/GovernorTimelockCompoundUpgradeable.sol";
import {ICompoundTimelock} from "@openzeppelin/contracts/vendor/compound/ICompoundTimelock.sol";
import {GovernorSettingsUpgradeable} from "contracts/extensions/GovernorSettingsUpgradeable.sol";
import {GovernorPreventLateQuorumUpgradeable} from "contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol";
import {IComp} from "contracts/interfaces/IComp.sol";
import {GovernorAlphaInterface} from "contracts/GovernorBravoInterfaces.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

/// @title CompoundGovernor
/// @author WOOF! Software
/// @notice A governance contract for the Compound DAO.
/// @custom:security-contact dmitriy@woof.software
contract CompoundGovernor is
    Initializable,
    GovernorVotesCompUpgradeable,
    GovernorTimelockCompoundUpgradeable,
    GovernorSettingsUpgradeable,
    GovernorCountingFractionalUpgradeable,
    GovernorPreventLateQuorumUpgradeable,
    GovernorSettableFixedQuorumUpgradeable,
    GovernorSequentialProposalIdUpgradeable
{
    /// @dev To use the `EnumerableSet` library for managing a set of addresses.
    using EnumerableSet for EnumerableSet.AddressSet;

    /**
     * @notice Emitted when the expiration of a whitelisted account is set or updated.
     * @param setter The address of the account that set the expiration.
     * @param account The address of the account being whitelisted.
     * @param expiration The timestamp until which the account is whitelisted.
     */
    event WhitelistAccountExpirationSet(address setter, address account, uint256 expiration);

    /// @notice Emitted when the whitelistGuardian is set or changed.
    /// @param oldGuardian The address of the previous whitelistGuardian.
    /// @param newGuardian The address of the new whitelistGuardian.
    event WhitelistGuardianSet(address oldGuardian, address newGuardian);

    /// @notice Emitted when the proposal guardian is set or updated.
    /// @param oldProposalGuardian The address of the previous proposal guardian.
    /// @param oldProposalGuardianExpiry The expiration timestamp of the previous proposal guardian's role.
    /// @param newProposalGuardian The address of the new proposal guardian.
    /// @param newProposalGuardianExpiry The expiration timestamp of the new proposal guardian's role.
    event ProposalGuardianSet(
        address oldProposalGuardian,
        uint96 oldProposalGuardianExpiry,
        address newProposalGuardian,
        uint96 newProposalGuardianExpiry
    );

    /// @notice Emitted when a new proposer is added to the allowed proposers list.
    /// @param proposer The address of the proposer that was added.
    event ProposerAdded(address indexed proposer);

    /// @notice Emitted when a proposer is removed from the allowed proposers list.
    /// @param proposer The address of the proposer that was removed.
    event ProposerRemoved(address indexed proposer);

    /// @notice Error thrown when an unauthorized address attempts to perform a restricted action.
    /// @param reason A brief description of why the caller is unauthorized.
    /// @param caller The address that attempted the unauthorized action.
    error Unauthorized(bytes32 reason, address caller);

    /// @notice Error thrown when a proposer attempts to create a new proposal while they have an active proposal.
    /// @param proposer The address of the proposer.
    /// @param proposalId The ID of the active proposal.
    /// @param state The state of the active proposal.
    error ProposerActiveProposal(address proposer, uint256 proposalId, ProposalState state);

    /// @notice Error thrown when a zero address is used.
    error ZeroAddress();

    /// @notice Error thrown when a zero address is used at a specific index.
    /// @param index The index where the zero address was used.
    error ZeroAddressAtIndex(uint256 index);

    /// @notice Error thrown when a caller is not an allowed proposer.
    error OnlyAllowedProposers();

    /// @notice Error thrown when an account is already set.
    /// @param account The address of the account that is already set.
    error AlreadySet(address account);

    /// @notice Error thrown when an account is the proposal guardian.
    /// @param account The address of the account that is the proposal guardian.
    error IsProposalGuardian(address account);

    /// @notice Error thrown when an account's lifetime exceeds the maximum lifetime.
    /// @param account The address of the account that exceeds the maximum lifetime.
    error ExceedsMaxLifetime(address account);

    /// @notice Error thrown when an account is not in the allowed proposers list.
    /// @param account The address of the account that is not in the allowed proposers list.
    error NotInAllowedProposers(address account);

    /// @notice Error thrown when amount of allowed proposers is below the minimum proposers.
    error BelowMinimumProposers();

    /// @notice Error thrown during batchWhitelist when the first address is not the proposal guardian.
    /// @param account The address of the account that is not the proposal guardian.
    error FirstMustBeProposalGuardian(address account);

    /// @notice Error thrown during batchWhitelist when an account is duplicated.
    /// @param account The address of the account that is already set.
    error DuplicateAddress(address account);

    /// @notice Error thrown when the minimum number of proposers is reached.
    /// @dev This error is thrown when the proposal guardian tries to add an allowed proposer when the minimum number of
    /// proposers is reached.
    error MinProposersReached();

    /// @notice Error thrown when a proposal is invalid because the proposal guardian has expired and only
    /// setProposalGuardian proposals are allowed.
    error InvalidProposalWhenGuardianExpired();

    /// @notice Error thrown when the caller is not the proxy admin.
    error OnlyProxyAdmin();

    /// @notice Error thrown when the caller is not the proposer or the proposal guardian.
    error OnlyProposerOrProposalGuardian();

    /// @notice The address and expiration of the proposal guardian.
    struct ProposalGuardian {
        // Address of the `ProposalGuardian`
        address account;
        // Timestamp at which the guardian loses the ability to cancel proposals
        uint96 expiration;
    }

    GovernorAlphaInterface private constant compoundGovernorBravo =
        GovernorAlphaInterface(0xc0Da02939E1441F497fd74F78cE7Decb17B66529);

    /// @notice Address which manages whitelisted proposals and whitelist accounts.
    /// @dev This address has the ability to set account whitelist expirations and can be changed through the governance
    /// process.
    address public whitelistGuardian;

    /// @notice Account which has the ability to cancel proposals. This privilege expires at the given expiration
    /// timestamp.
    ProposalGuardian public proposalGuardian;

    /// @notice Stores the expiration of account whitelist status as a timestamp.
    mapping(address account => uint256 timestamp) public whitelistAccountExpirations;

    /// @notice Stores the latest proposal ID for each proposer.
    mapping(address proposer => uint256 latestProposalId) public latestProposalIds;

    /*//////////////////////////////////////////////////////////////
                              NEW STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @notice The address of the proxy admin.
    /// @dev This is the address of the proxy admin that will be used to upgrade the proxy and call batchWhitelist.
    address public constant PROXY_ADMIN = 0x725ED7F44F0888aeC1b7630AB1ACdced91E0591A;

    /// @notice Minimum number of proposers that must remain in the allowed proposers list.
    uint8 public constant MIN_PROPOSERS = 5;

    /// @notice Maximum lifetime for a temporary proposer.
    uint32 public constant MAX_TEMPORARY_PROPOSER_LIFETIME = 365 days;

    /// @notice Function selector for setProposalGuardian(ProposalGuardian).
    bytes4 public constant SET_PROPOSAL_GUARDIAN_SELECTOR = 0xb80d105a;

    /// @notice A set of addresses that are allowed to make proposals.
    /// @dev Using EnumerableSet for managing the allow list.
    EnumerableSet.AddressSet private allowedProposers;

    /// @notice Disables the initialize function.
    constructor() {
        _disableInitializers();
    }

    /// @notice Initialize Governor.
    /// @param _initialVotingDelay The initial voting delay.
    /// @param _initialVotingPeriod The initial voting period.
    /// @param _initialProposalThreshold The initial proposal threshold.
    /// @param _compAddress The address of the Comp token.
    /// @param _quorumVotes The quorum votes.
    /// @param _timelockAddress The address of the Timelock.
    /// @param _initialVoteExtension The initial vote extension.
    /// @param _whitelistGuardian The address of the whitelist guardian.
    /// @param _proposalGuardian The proposal guardian.
    function initialize(
        uint48 _initialVotingDelay,
        uint32 _initialVotingPeriod,
        uint256 _initialProposalThreshold,
        IComp _compAddress,
        uint256 _quorumVotes,
        ICompoundTimelock _timelockAddress,
        uint48 _initialVoteExtension,
        address _whitelistGuardian,
        ProposalGuardian calldata _proposalGuardian
    ) public initializer {
        __Governor_init("Compound Governor");
        __GovernorSettings_init(_initialVotingDelay, _initialVotingPeriod, _initialProposalThreshold);
        __GovernorVotesComp_init(_compAddress);
        __GovernorTimelockCompound_init(_timelockAddress);
        __GovernorPreventLateQuorum_init(_initialVoteExtension);
        __GovernorSettableFixedQuorum_init(_quorumVotes);
        __GovernorSequentialProposalId_init();
        __GovernorCountingFractional_init();
        _setWhitelistGuardian(_whitelistGuardian);
        _setProposalGuardian(_proposalGuardian);
    }

    /**
     * @notice Batch initializes the allowed proposers list during upgrade.
     * @dev This function can only be called once during the upgrade process.
     * @param _initProposers Array of addresses to add to the allowed proposers list.
     */
    function batchWhitelist(address[] calldata _initProposers) external reinitializer(2) {
        if (_msgSender() != PROXY_ADMIN) {
            revert OnlyProxyAdmin();
        }

        if (_initProposers.length < MIN_PROPOSERS) {
            revert BelowMinimumProposers();
        }

        // First address must be proposalGuardian
        if (_initProposers[0] != proposalGuardian.account) {
            revert FirstMustBeProposalGuardian(_initProposers[0]);
        }

        // Check for zero addresses and duplicates
        address proposer;
        for (uint256 i; i < _initProposers.length;) {
            proposer = _initProposers[i];

            if (proposer == address(0)) {
                revert ZeroAddressAtIndex(i);
            }
            if (!allowedProposers.add(proposer)) {
                revert DuplicateAddress(proposer);
            }

            emit ProposerAdded(proposer);

            ++i;
        }
    }

    /// @notice Sets the next proposal ID. Designed to be callable once by the executor (timelock) on upgrade from
    /// Compound GovernorBravo.
    function setNextProposalId() external {
        if (_executor() != _msgSender()) {
            revert GovernorOnlyExecutor(_msgSender());
        }

        // In GovernorBravo, proposal IDs start at 1, so its proposalCount() function is the most recent
        // proposal ID created. This function sets the first proposal ID for the CompoundGovernor to 1 beyond that,
        // so the first proposal ID of compoundGovernor is one more that the last proposal ID of GovernorBravo.
        _setNextProposalId(compoundGovernorBravo.proposalCount() + 1);
    }

    /// @inheritdoc GovernorSequentialProposalIdUpgradeable
    /// @dev Since GovernorBravo indexed from 1, we decrement the proposal count by 1.
    function proposalCount() public view override returns (uint256) {
        return super.proposalCount() - 1;
    }

    /// @notice A modified `hashProposal` that supports sequential proposal IDs.
    function hashProposal(
        address[] memory _targets,
        uint256[] memory _values,
        bytes[] memory _calldatas,
        bytes32 _descriptionHash
    ) public virtual override(GovernorUpgradeable, GovernorSequentialProposalIdUpgradeable) returns (uint256) {
        return GovernorSequentialProposalIdUpgradeable.hashProposal(_targets, _values, _calldatas, _descriptionHash);
    }

    /// @notice Creates a new proposal. Skips proposal threshold check for whitelisted accounts.
    /// @param _targets An array of addresses that will be called if the proposal is executed.
    /// @param _values An array of ETH values to be sent to each address when the proposal is executed.
    /// @param _calldatas An array of calldata to be sent to each address when the proposal is executed.
    /// @param _description A human-readable description of the proposal.
    /// @return uint256 The ID of the newly created proposal.
    function propose(
        address[] memory _targets,
        uint256[] memory _values,
        bytes[] memory _calldatas,
        string memory _description
    ) public override(GovernorUpgradeable) returns (uint256) {
        address _proposer = _msgSender();

        // check description restriction
        if (!_isValidDescriptionForProposer(_proposer, _description)) {
            revert GovernorRestrictedProposer(_proposer);
        }

        // Check if proposer is in allowed proposers list or has temporary whitelist
        if (!isAllowedProposer(_proposer) && !isWhitelisted(_proposer)) {
            revert GovernorNotWhitelisted(_proposer);
        }

        // If proposal guardian has expired, only allow setProposalGuardian proposals
        if (isProposalGuardianExpired()) {
            if (!_isValidProposalWhenGuardianExpired(_targets, _calldatas)) {
                revert InvalidProposalWhenGuardianExpired();
            }
        }

        return _propose(_targets, _values, _calldatas, _description, _proposer);
    }

    /// @notice Internal function used to create a new proposal.
    /// @dev This is an override that supports sequential proposal IDs. Called by the public `propose` function.
    /// @param _targets An array of addresses that will be called if the proposal is executed.
    /// @param _values An array of ETH values to be sent to each address when the proposal is executed.
    /// @param _calldatas An array of calldata to be sent to each address when the proposal is executed.
    /// @param _description A human-readable description of the proposal.
    /// @param _proposer The address of the account creating the proposal.
    /// @return uint256 The ID of the newly created proposal.
    function _propose(
        address[] memory _targets,
        uint256[] memory _values,
        bytes[] memory _calldatas,
        string memory _description,
        address _proposer
    ) internal override(GovernorUpgradeable, GovernorSequentialProposalIdUpgradeable) returns (uint256) {
        uint256 _latestProposalId = latestProposalIds[_proposer];
        if (_latestProposalId != 0) {
            ProposalState _lastProposalState = state(_latestProposalId);
            if (_lastProposalState == ProposalState.Active || _lastProposalState == ProposalState.Pending) {
                revert ProposerActiveProposal(_proposer, _latestProposalId, _lastProposalState);
            }
        }
        uint256 _proposalId =
            GovernorSequentialProposalIdUpgradeable._propose(_targets, _values, _calldatas, _description, _proposer);
        latestProposalIds[_proposer] = _proposalId;
        return _proposalId;
    }

    /**
     * @notice Cancels an active proposal.
     * @dev This function can be called by the proposer or proposal guardian.
     * @param _targets An array of addresses that will be called if the proposal is executed.
     * @param _values An array of ETH values to be sent to each address when the proposal is executed.
     * @param _calldatas An array of calldata to be sent to each address when the proposal is executed.
     * @param _descriptionHash The hash of the proposal's description string.
     * @return uint256 The ID of the canceled proposal.
     */
    function cancel(
        address[] memory _targets,
        uint256[] memory _values,
        bytes[] memory _calldatas,
        bytes32 _descriptionHash
    ) public override returns (uint256) {
        uint256 _proposalId = hashProposal(_targets, _values, _calldatas, _descriptionHash);
        address _proposer = proposalProposer(_proposalId);

        // Only proposer and proposal guardian can cancel.
        if (
            _msgSender() != _proposer
                && (_msgSender() != proposalGuardian.account || block.timestamp > proposalGuardian.expiration)
        ) {
            revert OnlyProposerOrProposalGuardian();
        }

        return _cancel(_targets, _values, _calldatas, _descriptionHash);
    }

    /**
     * @notice Cancels a proposal given its ID.
     * @dev This function can be called by the proposer or proposal guardian.
     *      It retrieves proposal details and calls the main cancel function with those details.
     * @param _proposalId The ID of the proposal to cancel.
     */
    function cancel(uint256 _proposalId) public override {
        (address[] memory _targets, uint256[] memory _values, bytes[] memory _calldatas, bytes32 _descriptionHash) =
            proposalDetails(_proposalId);
        cancel(_targets, _values, _calldatas, _descriptionHash);
    }

    /**
     * @notice Sets or updates the whitelist expiration for a specific account.
     * A whitelisted account can create proposals without needing to be an allowed proposer.
     * A whitelisted account's proposals cannot be canceled by anyone except the `whitelistGuardian`.
     * A whitelisted account and `proposalGuardian` can still cancel its proposals.
     * @dev Only an allowed proposer can call this function to whitelist other accounts.
     * @param _account The address of the account to be whitelisted.
     * @param _expiration The timestamp until which the account will be whitelisted.
     */
    function setWhitelistAccountExpiration(address _account, uint256 _expiration) external {
        address _sender = _msgSender();
        // Check that msg.sender is in allowedProposers
        if (!allowedProposers.contains(_sender)) {
            revert OnlyAllowedProposers();
        }

        // Check that _account is not zero address
        if (_account == address(0)) {
            revert ZeroAddress();
        }

        // Check that _account is not in allowedProposers
        if (allowedProposers.contains(_account)) {
            revert AlreadySet(_account);
        }

        // Check that _account is not equal to proposalGuardian
        if (_account == proposalGuardian.account) {
            revert IsProposalGuardian(_account);
        }

        // If expiration is not less than now, check the lifetime constraint
        if (_expiration > block.timestamp && _expiration - block.timestamp > MAX_TEMPORARY_PROPOSER_LIFETIME) {
            revert ExceedsMaxLifetime(_account);
        }

        whitelistAccountExpirations[_account] = _expiration;
        emit WhitelistAccountExpirationSet(_sender, _account, _expiration);
    }

    /**
     * @notice Adds a new address to the allowed proposers list.
     * @dev Only the executor (timelock) or proposal guardian (when below minimum proposers) can call this function.
     * @param _newProposer The address to add to the allowed proposers list.
     */
    function addProposer(address _newProposer) external {
        address _sender = _msgSender();
        address _proposalGuardian = proposalGuardian.account;

        /**
         * Note Proposers can always be added by proposals
         * Note Proposal guardian can add proposers when below minimum proposers even if he is expired
         * This was done to prevent a case after upgrade where whitelist proposers expired and non of allowed
         * proposers were whitelisted
         * Note Proposal guardian can only add proposers when below minimum
         */
        if (_sender != _executor()) {
            if (_sender != proposalGuardian.account) {
                revert GovernorOnlyExecutor(_sender);
            }
            if (allowedProposers.length() > MIN_PROPOSERS) {
                revert MinProposersReached();
            }
        }

        if (_newProposer == address(0)) {
            revert ZeroAddress();
        }

        if (_newProposer == _proposalGuardian) {
            revert IsProposalGuardian(_newProposer);
        }

        if (isAllowedProposer(_newProposer)) {
            revert AlreadySet(_newProposer);
        }

        allowedProposers.add(_newProposer);
        emit ProposerAdded(_newProposer);
    }

    /**
     * @notice Removes an address from the allowed proposers list.
     * @dev Only the executor (timelock) can call this function.
     * @param _proposer The address to remove from the allowed proposers list.
     */
    function removeProposer(address _proposer) external {
        if (_executor() != _msgSender()) {
            revert GovernorOnlyExecutor(_msgSender());
        }

        if (_proposer == address(0)) {
            revert ZeroAddress();
        }

        if (_proposer == proposalGuardian.account) {
            revert IsProposalGuardian(_proposer);
        }

        if (!isAllowedProposer(_proposer)) {
            revert NotInAllowedProposers(_proposer);
        }

        if (allowedProposers.length() <= MIN_PROPOSERS) {
            revert BelowMinimumProposers();
        }

        allowedProposers.remove(_proposer);
        emit ProposerRemoved(_proposer);
    }

    /// @notice Checks if an account is currently whitelisted.
    /// @param _account The address of the account to check.
    /// @return bool Returns true if the account is whitelisted (expiration is in the future), false otherwise.
    function isWhitelisted(address _account) public view returns (bool) {
        return (whitelistAccountExpirations[_account] > block.timestamp);
    }

    /// @notice Returns the list of allowed proposers.
    /// @return address[] An array of addresses that are allowed to make proposals.
    function getAllowedProposers() public view returns (address[] memory) {
        return allowedProposers.values();
    }

    /// @notice Checks if an address is in the allowed proposers list.
    /// @param _account The address to check.
    /// @return bool True if the address is an allowed proposer.
    function isAllowedProposer(address _account) public view returns (bool) {
        return allowedProposers.contains(_account);
    }

    /// @notice Checks if the proposal guardian has expired.
    /// @return bool True if the proposal guardian has expired, false otherwise.
    function isProposalGuardianExpired() public view returns (bool) {
        return block.timestamp > proposalGuardian.expiration;
    }

    /// @notice Validates that a proposal contains exactly one setProposalGuardian call.
    /// @param _targets An array of addresses that will be called if the proposal is executed.
    /// @param _calldatas An array of calldata to be sent to each address when the proposal is executed.
    /// @return bool True if the proposal contains exactly one setProposalGuardian call, false otherwise.
    function _isValidProposalWhenGuardianExpired(address[] memory _targets, bytes[] memory _calldatas)
        internal
        view
        returns (bool)
    {
        // Must have exactly one call when guardian has expired
        if (_targets.length != 1 || _calldatas.length != 1) {
            return false;
        }

        // Check that the single call is to this contract and uses setProposalGuardian selector
        if (_targets[0] != address(this)) {
            return false;
        }

        // Check that the calldata is the setProposalGuardian selector
        bytes4 selector = bytes4(_calldatas[0]);
        if (selector != SET_PROPOSAL_GUARDIAN_SELECTOR) {
            return false;
        }

        return true;
    }

    /// @notice Sets a new `whitelistGuardian`.
    /// @notice a `whitelistGuardian` can whitelist accounts and can cancel whitelisted accounts' proposals when they
    /// fall.
    /// below `proposalThreshold.
    /// @dev Only the executor (timelock) can call this function.
    /// @param _newWhitelistGuardian The address of the new `whitelistGuardian`.
    function setWhitelistGuardian(address _newWhitelistGuardian) external {
        _checkGovernance();
        _setWhitelistGuardian(_newWhitelistGuardian);
    }

    /// @notice Sets a new proposal guardian.
    /// @dev This function can only be called by the executor (timelock).
    /// @param _newProposalGuardian The new proposal guardian to be set, including their address and expiration.
    function setProposalGuardian(ProposalGuardian memory _newProposalGuardian) external {
        _checkGovernance();
        _setProposalGuardian(_newProposalGuardian);
    }

    /// @notice Admin function for setting the whitelistGuardian. WhitelistGuardian can cancel proposals from
    /// whitelisted addresses.
    /// @param _newWhitelistGuardian Account to set whitelistGuardian to (0x0 to remove whitelistGuardian).
    function _setWhitelistGuardian(address _newWhitelistGuardian) internal {
        emit WhitelistGuardianSet(whitelistGuardian, _newWhitelistGuardian);
        whitelistGuardian = _newWhitelistGuardian;
    }

    /**
     * @notice Internal function to set a new proposal guardian.
     * @dev Updates the proposal guardian and emits a {ProposalGuardianSet} event.
     *      If the new proposal guardian is different from the current one, the current proposal guardian
     *      is removed from the allowed proposers and the new proposal guardian is added.
     * @param _newProposalGuardian The new proposal guardian to be set, including their address and expiration.
     */
    function _setProposalGuardian(ProposalGuardian memory _newProposalGuardian) internal {
        address currentProposalGuardian = proposalGuardian.account;
        address newProposalGuardian = _newProposalGuardian.account;
        emit ProposalGuardianSet(
            currentProposalGuardian, proposalGuardian.expiration, newProposalGuardian, _newProposalGuardian.expiration
        );

        /// Note If batchWhitelist was not called during upgrade, we check that the current proposal guardian is in the
        /// allowed proposers
        if (currentProposalGuardian != newProposalGuardian) {
            if (isAllowedProposer(currentProposalGuardian)) {
                allowedProposers.remove(currentProposalGuardian);
            }
            allowedProposers.add(newProposalGuardian);
        }

        proposalGuardian = _newProposalGuardian;
    }

    /// @inheritdoc GovernorTimelockCompoundUpgradeable
    /// @dev We override this function to resolve ambiguity between inherited contracts.
    function _cancel(
        address[] memory _targets,
        uint256[] memory _values,
        bytes[] memory _calldatas,
        bytes32 _descriptionHash
    ) internal override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable) returns (uint256) {
        return GovernorTimelockCompoundUpgradeable._cancel(_targets, _values, _calldatas, _descriptionHash);
    }

    /// @inheritdoc GovernorPreventLateQuorumUpgradeable
    /// @dev We override this function to resolve ambiguity between inherited contracts.
    function _castVote(
        uint256 _proposalId,
        address _account,
        uint8 _support,
        string memory _reason,
        bytes memory _params
    ) internal override(GovernorUpgradeable, GovernorPreventLateQuorumUpgradeable) returns (uint256) {
        return GovernorPreventLateQuorumUpgradeable._castVote(_proposalId, _account, _support, _reason, _params);
    }

    /// @inheritdoc GovernorTimelockCompoundUpgradeable
    /// @dev We override this function to resolve ambiguity between inherited contracts.
    function _executeOperations(
        uint256 _proposalId,
        address[] memory _targets,
        uint256[] memory _values,
        bytes[] memory _calldatas,
        bytes32 _descriptionHash
    ) internal override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable) {
        return GovernorTimelockCompoundUpgradeable._executeOperations(
            _proposalId, _targets, _values, _calldatas, _descriptionHash
        );
    }

    /// @inheritdoc GovernorTimelockCompoundUpgradeable
    function _executor()
        internal
        view
        override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable)
        returns (address)
    {
        return GovernorTimelockCompoundUpgradeable._executor();
    }

    /// @inheritdoc GovernorTimelockCompoundUpgradeable
    /// @dev We override this function to resolve ambiguity between inherited contracts.
    function _queueOperations(
        uint256 _proposalId,
        address[] memory _targets,
        uint256[] memory _values,
        bytes[] memory _calldatas,
        bytes32 _descriptionHash
    ) internal override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable) returns (uint48) {
        return GovernorTimelockCompoundUpgradeable._queueOperations(
            _proposalId, _targets, _values, _calldatas, _descriptionHash
        );
    }

    /// @inheritdoc GovernorPreventLateQuorumUpgradeable
    /// @dev We override this function to resolve ambiguity between inherited contracts.
    function proposalDeadline(uint256 _proposalId)
        public
        view
        override(GovernorPreventLateQuorumUpgradeable, GovernorUpgradeable)
        returns (uint256)
    {
        return GovernorPreventLateQuorumUpgradeable.proposalDeadline(_proposalId);
    }

    /// @inheritdoc GovernorTimelockCompoundUpgradeable
    /// @dev We override this function to resolve ambiguity between inherited contracts.
    function proposalNeedsQueuing(uint256 _proposalId)
        public
        view
        override(GovernorTimelockCompoundUpgradeable, GovernorUpgradeable)
        returns (bool)
    {
        return GovernorTimelockCompoundUpgradeable.proposalNeedsQueuing(_proposalId);
    }

    /// @inheritdoc GovernorSettingsUpgradeable
    /// @dev We override this function to resolve ambiguity between inherited contracts.
    function proposalThreshold()
        public
        view
        override(GovernorSettingsUpgradeable, GovernorUpgradeable)
        returns (uint256)
    {
        return GovernorSettingsUpgradeable.proposalThreshold();
    }

    /// @inheritdoc GovernorTimelockCompoundUpgradeable
    /// @dev We override this function to resolve ambiguity between inherited contracts.
    function state(uint256 _proposalId)
        public
        view
        override(GovernorUpgradeable, GovernorTimelockCompoundUpgradeable)
        returns (ProposalState)
    {
        return GovernorTimelockCompoundUpgradeable.state(_proposalId);
    }

    /// @inheritdoc GovernorCountingFractionalUpgradeable
    // solhint-disable-next-line func-name-mixedcase
    function COUNTING_MODE()
        public
        pure
        override(IGovernor, GovernorCountingFractionalUpgradeable)
        returns (string memory)
    {
        return "support=bravo,fractional&quorum=for&params=fractional";
    }

    /// @notice Internal function that returns true if the amount of 'for' votes already cast meets the quorum limit,
    /// false otherwise.
    /// @dev We override this function to implement quorum functionality that only includes votes in favor.
    function _quorumReached(uint256 proposalId)
        internal
        view
        override(GovernorUpgradeable, GovernorCountingFractionalUpgradeable)
        returns (bool)
    {
        (, uint256 _forVotes,) = GovernorCountingFractionalUpgradeable.proposalVotes(proposalId);
        return quorum(proposalSnapshot(proposalId)) <= _forVotes;
    }
}
