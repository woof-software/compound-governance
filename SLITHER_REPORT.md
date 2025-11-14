**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [solc-version](#solc-version) (8 results) (Informational)
 - [missing-zero-check](#missing-zero-check) (7 results) (Low)
 - [reentrancy-events](#reentrancy-events) (5 results) (Low)
 - [timestamp](#timestamp) (15 results) (Low)
 - [low-level-calls](#low-level-calls) (10 results) (Informational)
 - [naming-convention](#naming-convention) (117 results) (Informational)
 - [locked-ether](#locked-ether) (1 results) (Medium)
 - [reentrancy-no-eth](#reentrancy-no-eth) (2 results) (Medium)
 - [unused-return](#unused-return) (14 results) (Medium)
 - [shadowing-local](#shadowing-local) (1 results) (Low)
 - [events-maths](#events-maths) (2 results) (Low)
 - [calls-loop](#calls-loop) (13 results) (Low)
 - [assembly](#assembly) (35 results) (Informational)
 - [boolean-equal](#boolean-equal) (1 results) (Informational)
 - [constable-states](#constable-states) (2 results) (Optimization)
 - [incorrect-equality](#incorrect-equality) (1 results) (Medium)
 - [too-many-digits](#too-many-digits) (1 results) (Informational)
 - [controlled-delegatecall](#controlled-delegatecall) (2 results) (High)
 - [immutable-states](#immutable-states) (1 results) (Optimization)
 - [arbitrary-send-eth](#arbitrary-send-eth) (2 results) (High)
 - [incorrect-exp](#incorrect-exp) (1 results) (High)
 - [divide-before-multiply](#divide-before-multiply) (9 results) (Medium)
 - [pragma](#pragma) (1 results) (Informational)
 - [dead-code](#dead-code) (14 results) (Informational)
 - [unimplemented-functions](#unimplemented-functions) (1 results) (Informational)
## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-0
Version constraint ^0.8.10 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation.
It is used by:
	- [^0.8.10](contracts/SafeMath.sol#L2)

contracts/SafeMath.sol#L2


 - [ ] ID-1
Version constraint ^0.8.10 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation.
It is used by:
	- [^0.8.10](contracts/SafeMath.sol#L2)
	- [^0.8.10](contracts/Timelock.sol#L2)

contracts/SafeMath.sol#L2


 - [ ] ID-2
Version constraint ^0.8.10 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation.
It is used by:
	- [^0.8.10](contracts/GovernorBravoInterfaces.sol#L2)

contracts/GovernorBravoInterfaces.sol#L2


 - [ ] ID-3
Version constraint ^0.8.10 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation.
It is used by:
	- [^0.8.10](contracts/GovernorBravoDelegate.sol#L2)
	- [^0.8.10](contracts/GovernorBravoInterfaces.sol#L2)

contracts/GovernorBravoDelegate.sol#L2


 - [ ] ID-4
Version constraint ^0.8.10 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation.
It is used by:
	- [^0.8.10](contracts/Comp.sol#L2)

contracts/Comp.sol#L2


 - [ ] ID-5
Version constraint ^0.8.10 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation.
It is used by:
	- [^0.8.10](contracts/GovernorBravoDelegator.sol#L2)
	- [^0.8.10](contracts/GovernorBravoInterfaces.sol#L2)

contracts/GovernorBravoDelegator.sol#L2


 - [ ] ID-6
Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess.
It is used by:
	- [^0.8.20](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L5)
	- [^0.8.20](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L5)
	- [^0.8.20](contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L5)
	- [^0.8.20](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L3)
	- [^0.8.20](contracts/extensions/GovernorSettingsUpgradeable.sol#L5)
	- [^0.8.20](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L5)
	- [^0.8.20](contracts/extensions/GovernorUpgradeable.sol#L5)
	- [^0.8.20](contracts/extensions/IGovernor.sol#L5)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L3)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC1271.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC165.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC6372.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC1155/IERC1155Receiver.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Errors.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#L5)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L5)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/DoubleEndedQueue.sol#L3)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L5)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/types/Time.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/vendor/compound/ICompoundTimelock.sol#L4)

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L5


 - [ ] ID-7
Version constraint ^0.8.10 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- DataLocationChangeInInternalOverride
	- NestedCalldataArrayAbiReencodingSizeValidation.
It is used by:
	- [^0.8.10](contracts/GovernorBravoInterfaces.sol#L2)

contracts/GovernorBravoInterfaces.sol#L2


## missing-zero-check
Impact: Low
Confidence: Medium
 - [ ] ID-8
[Timelock.constructor(address,uint256).admin_](contracts/Timelock.sol#L27) lacks a zero-check on :
		- [admin = admin_](contracts/Timelock.sol#L31)

contracts/Timelock.sol#L27


 - [ ] ID-9
[Timelock.setPendingAdmin(address).pendingAdmin_](contracts/Timelock.sol#L54) lacks a zero-check on :
		- [pendingAdmin = pendingAdmin_](contracts/Timelock.sol#L56)

contracts/Timelock.sol#L54


 - [ ] ID-10
[Timelock.executeTransaction(address,uint256,string,bytes,uint256).target](contracts/Timelock.sol#L81) lacks a zero-check on :
		- [(success,returnData) = target.call{value: value}(callData)](contracts/Timelock.sol#L100)

contracts/Timelock.sol#L81


 - [ ] ID-11
[GovernorBravoDelegate._setWhitelistGuardian(address).account](contracts/GovernorBravoDelegate.sol#L563) lacks a zero-check on :
		- [whitelistGuardian = account](contracts/GovernorBravoDelegate.sol#L566)

contracts/GovernorBravoDelegate.sol#L563


 - [ ] ID-12
[GovernorBravoDelegate._setPendingAdmin(address).newPendingAdmin](contracts/GovernorBravoDelegate.sol#L607) lacks a zero-check on :
		- [pendingAdmin = newPendingAdmin](contracts/GovernorBravoDelegate.sol#L615)

contracts/GovernorBravoDelegate.sol#L607


 - [ ] ID-13
[GovernorBravoDelegator.constructor(address,address,address,address,uint256,uint256,uint256).admin_](contracts/GovernorBravoDelegator.sol#L13) lacks a zero-check on :
		- [admin = admin_](contracts/GovernorBravoDelegator.sol#L36)

contracts/GovernorBravoDelegator.sol#L13


 - [ ] ID-14
[GovernorUpgradeable.relay(address,uint256,bytes).target](contracts/extensions/GovernorUpgradeable.sol#L693) lacks a zero-check on :
		- [(success,returndata) = target.call{value: value}(data)](contracts/extensions/GovernorUpgradeable.sol#L694)

contracts/extensions/GovernorUpgradeable.sol#L693


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-15
Reentrancy in [Timelock.executeTransaction(address,uint256,string,bytes,uint256)](contracts/Timelock.sol#L81-L106):
	External calls:
	- [(success,returnData) = target.call{value: value}(callData)](contracts/Timelock.sol#L100)
	Event emitted after the call(s):
	- [ExecuteTransaction(txHash,target,value,signature,data,eta)](contracts/Timelock.sol#L103)

contracts/Timelock.sol#L81-L106


 - [ ] ID-16
Reentrancy in [GovernorBravoDelegate.execute(uint256)](contracts/GovernorBravoDelegate.sol#L278-L291):
	External calls:
	- [timelock.executeTransaction(proposal.targets[i],proposal.values[i],proposal.signatures[i],proposal.calldatas[i],proposal.eta)](contracts/GovernorBravoDelegate.sol#L286-L288)
	Event emitted after the call(s):
	- [ProposalExecuted(proposalId)](contracts/GovernorBravoDelegate.sol#L290)

contracts/GovernorBravoDelegate.sol#L278-L291


 - [ ] ID-17
Reentrancy in [GovernorBravoDelegate.queue(uint256)](contracts/GovernorBravoDelegate.sol#L244-L258):
	External calls:
	- [queueOrRevertInternal(proposal.targets[i],proposal.values[i],proposal.signatures[i],proposal.calldatas[i],eta)](contracts/GovernorBravoDelegate.sol#L252-L254)
		- [timelock.queueTransaction(target,value,signature,data,eta)](contracts/GovernorBravoDelegate.sol#L271)
	Event emitted after the call(s):
	- [ProposalQueued(proposalId,eta)](contracts/GovernorBravoDelegate.sol#L257)

contracts/GovernorBravoDelegate.sol#L244-L258


 - [ ] ID-18
Reentrancy in [GovernorBravoDelegate.cancel(uint256)](contracts/GovernorBravoDelegate.sol#L298-L328):
	External calls:
	- [timelock.cancelTransaction(proposal.targets[i],proposal.values[i],proposal.signatures[i],proposal.calldatas[i],proposal.eta)](contracts/GovernorBravoDelegate.sol#L322-L324)
	Event emitted after the call(s):
	- [ProposalCanceled(proposalId)](contracts/GovernorBravoDelegate.sol#L327)

contracts/GovernorBravoDelegate.sol#L298-L328


 - [ ] ID-19
Reentrancy in [GovernorUpgradeable.execute(address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorUpgradeable.sol#L426-L462):
	External calls:
	- [_executeOperations(proposalId,targets,values,calldatas,descriptionHash)](contracts/extensions/GovernorUpgradeable.sol#L452)
		- [(success,returndata) = targets[i].call{value: values[i]}(calldatas[i])](contracts/extensions/GovernorUpgradeable.sol#L479)
	Event emitted after the call(s):
	- [ProposalExecuted(proposalId)](contracts/extensions/GovernorUpgradeable.sol#L459)

contracts/extensions/GovernorUpgradeable.sol#L426-L462


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-20
[Timelock.executeTransaction(address,uint256,string,bytes,uint256)](contracts/Timelock.sol#L81-L106) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(getBlockTimestamp() >= eta,Timelock::executeTransaction: Transaction hasn't surpassed time lock.)](contracts/Timelock.sol#L86)
	- [require(bool,string)(getBlockTimestamp() <= eta.add(GRACE_PERIOD),Timelock::executeTransaction: Transaction is stale.)](contracts/Timelock.sol#L87)

contracts/Timelock.sol#L81-L106


 - [ ] ID-21
[Timelock.queueTransaction(address,uint256,string,bytes,uint256)](contracts/Timelock.sol#L61-L70) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(eta >= getBlockTimestamp().add(delay),Timelock::queueTransaction: Estimated execution block must satisfy delay.)](contracts/Timelock.sol#L63)

contracts/Timelock.sol#L61-L70


 - [ ] ID-22
[GovernorBravoDelegate.isWhitelisted(address)](contracts/GovernorBravoDelegate.sol#L489-L491) uses timestamp for comparisons
	Dangerous comparisons:
	- [(whitelistAccountExpirations[account] > block.timestamp)](contracts/GovernorBravoDelegate.sol#L490)

contracts/GovernorBravoDelegate.sol#L489-L491


 - [ ] ID-23
[GovernorBravoDelegate.cancel(uint256)](contracts/GovernorBravoDelegate.sol#L298-L328) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)((comp.getPriorVotes(proposal.proposer,block.number - 1) < proposalThreshold),GovernorBravo::cancel: proposer above threshold)](contracts/GovernorBravoDelegate.sol#L309-L312)
	- [proposalGuardian.expiration >= block.timestamp](contracts/GovernorBravoDelegate.sol#L304-L305)

contracts/GovernorBravoDelegate.sol#L298-L328


 - [ ] ID-24
[GovernorBravoDelegate.state(uint256)](contracts/GovernorBravoDelegate.sol#L367-L389) uses timestamp for comparisons
	Dangerous comparisons:
	- [block.timestamp >= proposal.eta + timelock.GRACE_PERIOD()](contracts/GovernorBravoDelegate.sol#L384)

contracts/GovernorBravoDelegate.sol#L367-L389


 - [ ] ID-25
[GovernorBravoDelegate.proposeInternal(address,address[],uint256[],string[],bytes[],string)](contracts/GovernorBravoDelegate.sol#L174-L238) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(comp.getPriorVotes(proposer,block.number - 1) > proposalThreshold || isWhitelisted(proposer),GovernorBravo::proposeInternal: proposer votes below proposal threshold)](contracts/GovernorBravoDelegate.sol#L185-L188)
	- [require(bool,string)(newProposal.id == 0,GovernorBravo::proposeInternal: ProposalID collision)](contracts/GovernorBravoDelegate.sol#L216)

contracts/GovernorBravoDelegate.sol#L174-L238


 - [ ] ID-26
[GovernorBravoDelegate.queueOrRevertInternal(address,uint256,string,bytes,uint256)](contracts/GovernorBravoDelegate.sol#L260-L272) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(! timelock.queuedTransactions(keccak256(bytes)(abi.encode(target,value,signature,data,eta))),GovernorBravo::queueOrRevertInternal: identical proposal action already queued at eta)](contracts/GovernorBravoDelegate.sol#L267-L270)

contracts/GovernorBravoDelegate.sol#L260-L272


 - [ ] ID-27
[Comp.delegateBySig(address,uint256,uint256,uint8,bytes32,bytes32)](contracts/Comp.sol#L161-L170) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(block.timestamp <= expiry,Comp::delegateBySig: signature expired)](contracts/Comp.sol#L168)

contracts/Comp.sol#L161-L170


 - [ ] ID-28
[CompoundGovernor.setWhitelistAccountExpiration(address,uint256)](contracts/CompoundGovernor.sol#L394-L423) uses timestamp for comparisons
	Dangerous comparisons:
	- [_expiration > block.timestamp && _expiration - block.timestamp > MAX_TEMPORARY_PROPOSER_LIFETIME](contracts/CompoundGovernor.sol#L417)

contracts/CompoundGovernor.sol#L394-L423


 - [ ] ID-29
[Time._getFullAt(Time.Delay,uint48)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/types/Time.sol#L74-L80) uses timestamp for comparisons
	Dangerous comparisons:
	- [effect <= timepoint](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/types/Time.sol#L79)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/types/Time.sol#L74-L80


 - [ ] ID-30
[CompoundGovernor.isProposalGuardianExpired()](contracts/CompoundGovernor.sol#L518-L520) uses timestamp for comparisons
	Dangerous comparisons:
	- [block.timestamp > proposalGuardian.expiration](contracts/CompoundGovernor.sol#L519)

contracts/CompoundGovernor.sol#L518-L520


 - [ ] ID-31
[GovernorTimelockCompoundUpgradeable.state(uint256)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L58-L67) uses timestamp for comparisons
	Dangerous comparisons:
	- [(currentState == ProposalState.Queued && block.timestamp >= proposalEta(proposalId) + $._timelock.GRACE_PERIOD())](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L62-L66)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L58-L67


 - [ ] ID-32
[CompoundGovernor.cancel(address[],uint256[],bytes[],bytes32)](contracts/CompoundGovernor.sol#L353-L371) uses timestamp for comparisons
	Dangerous comparisons:
	- [_msgSender() != _proposer && (_msgSender() != proposalGuardian.account || block.timestamp > proposalGuardian.expiration)](contracts/CompoundGovernor.sol#L364-L365)

contracts/CompoundGovernor.sol#L353-L371


 - [ ] ID-33
[CompoundGovernor.propose(address[],uint256[],bytes[],string)](contracts/CompoundGovernor.sol#L288-L314) uses timestamp for comparisons
	Dangerous comparisons:
	- [! isAllowedProposer(_proposer) && ! isWhitelisted(_proposer)](contracts/CompoundGovernor.sol#L302)

contracts/CompoundGovernor.sol#L288-L314


 - [ ] ID-34
[CompoundGovernor.isWhitelisted(address)](contracts/CompoundGovernor.sol#L499-L501) uses timestamp for comparisons
	Dangerous comparisons:
	- [(whitelistAccountExpirations[_account] > block.timestamp)](contracts/CompoundGovernor.sol#L500)

contracts/CompoundGovernor.sol#L499-L501


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-35
Low level call in [Timelock.executeTransaction(address,uint256,string,bytes,uint256)](contracts/Timelock.sol#L81-L106):
	- [(success,returnData) = target.call{value: value}(callData)](contracts/Timelock.sol#L100)

contracts/Timelock.sol#L81-L106


 - [ ] ID-36
Low level call in [GovernorBravoDelegator.delegateTo(address,bytes)](contracts/GovernorBravoDelegator.sol#L65-L72):
	- [(success,returnData) = callee.delegatecall(data)](contracts/GovernorBravoDelegator.sol#L66)

contracts/GovernorBravoDelegator.sol#L65-L72


 - [ ] ID-37
Low level call in [GovernorBravoDelegator.fallback()](contracts/GovernorBravoDelegator.sol#L79-L95):
	- [(success,None) = implementation.delegatecall(msg.data)](contracts/GovernorBravoDelegator.sol#L81)

contracts/GovernorBravoDelegator.sol#L79-L95


 - [ ] ID-38
Low level call in [Address.functionStaticCall(address,bytes)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L87-L90):
	- [(success,returndata) = target.staticcall(data)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L88)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L87-L90


 - [ ] ID-39
Low level call in [GovernorUpgradeable.relay(address,uint256,bytes)](contracts/extensions/GovernorUpgradeable.sol#L693-L696):
	- [(success,returndata) = target.call{value: value}(data)](contracts/extensions/GovernorUpgradeable.sol#L694)

contracts/extensions/GovernorUpgradeable.sol#L693-L696


 - [ ] ID-40
Low level call in [SignatureChecker.isValidERC1271SignatureNow(address,bytes32,bytes)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol#L38-L49):
	- [(success,result) = signer.staticcall(abi.encodeCall(IERC1271.isValidSignature,(hash,signature)))](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol#L43-L45)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol#L38-L49


 - [ ] ID-41
Low level call in [GovernorUpgradeable._executeOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorUpgradeable.sol#L471-L482):
	- [(success,returndata) = targets[i].call{value: values[i]}(calldatas[i])](contracts/extensions/GovernorUpgradeable.sol#L479)

contracts/extensions/GovernorUpgradeable.sol#L471-L482


 - [ ] ID-42
Low level call in [Address.functionCallWithValue(address,bytes,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L75-L81):
	- [(success,returndata) = target.call{value: value}(data)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L79)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L75-L81


 - [ ] ID-43
Low level call in [Address.sendValue(address,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L33-L42):
	- [(success,None) = recipient.call{value: amount}()](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L38)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L33-L42


 - [ ] ID-44
Low level call in [Address.functionDelegateCall(address,bytes)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L96-L99):
	- [(success,returndata) = target.delegatecall(data)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L97)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L96-L99


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-45
Function [TimelockInterface.GRACE_PERIOD()](contracts/GovernorBravoInterfaces.sol#L199) is not in mixedCase

contracts/GovernorBravoInterfaces.sol#L199


 - [ ] ID-46
Function [GovernorBravoDelegate._initiate(address)](contracts/GovernorBravoDelegate.sol#L593-L599) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L593-L599


 - [ ] ID-47
Function [GovernorBravoDelegate._setProposalThreshold(uint256)](contracts/GovernorBravoDelegate.sol#L530-L540) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L530-L540


 - [ ] ID-48
Function [GovernorBravoDelegate._acceptAdmin()](contracts/GovernorBravoDelegate.sol#L625-L643) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L625-L643


 - [ ] ID-49
Function [GovernorBravoDelegate._setProposalGuardian(GovernorBravoDelegateStorageV3.ProposalGuardian)](contracts/GovernorBravoDelegate.sol#L575-L586) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L575-L586


 - [ ] ID-50
Function [GovernorBravoDelegate._setWhitelistGuardian(address)](contracts/GovernorBravoDelegate.sol#L563-L569) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L563-L569


 - [ ] ID-51
Function [TimelockInterface.GRACE_PERIOD()](contracts/GovernorBravoInterfaces.sol#L199) is not in mixedCase

contracts/GovernorBravoInterfaces.sol#L199


 - [ ] ID-52
Function [GovernorBravoDelegate._setVotingPeriod(uint256)](contracts/GovernorBravoDelegate.sol#L513-L523) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L513-L523


 - [ ] ID-53
Function [GovernorBravoDelegate._setVotingDelay(uint256)](contracts/GovernorBravoDelegate.sol#L497-L507) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L497-L507


 - [ ] ID-54
Function [GovernorBravoDelegate._setWhitelistAccountExpiration(address,uint256)](contracts/GovernorBravoDelegate.sol#L548-L556) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L548-L556


 - [ ] ID-55
Function [GovernorBravoDelegate._setPendingAdmin(address)](contracts/GovernorBravoDelegate.sol#L607-L619) is not in mixedCase

contracts/GovernorBravoDelegate.sol#L607-L619


 - [ ] ID-56
Function [GovernorBravoDelegator._setImplementation(address)](contracts/GovernorBravoDelegator.sol#L43-L57) is not in mixedCase

contracts/GovernorBravoDelegator.sol#L43-L57


 - [ ] ID-57
Function [TimelockInterface.GRACE_PERIOD()](contracts/GovernorBravoInterfaces.sol#L199) is not in mixedCase

contracts/GovernorBravoInterfaces.sol#L199


 - [ ] ID-58
Constant [NoncesUpgradeable.NoncesStorageLocation](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L21) is not in UPPER_CASE_WITH_UNDERSCORES

lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L21


 - [ ] ID-59
Parameter [CompoundGovernor.proposalNeedsQueuing(uint256)._proposalId](contracts/CompoundGovernor.sol#L675) is not in mixedCase

contracts/CompoundGovernor.sol#L675


 - [ ] ID-60
Parameter [CompoundGovernor.hashProposal(address[],uint256[],bytes[],bytes32)._descriptionHash](contracts/CompoundGovernor.sol#L277) is not in mixedCase

contracts/CompoundGovernor.sol#L277


 - [ ] ID-61
Parameter [CompoundGovernor.isWhitelisted(address)._account](contracts/CompoundGovernor.sol#L499) is not in mixedCase

contracts/CompoundGovernor.sol#L499


 - [ ] ID-62
Function [ICompoundTimelock.GRACE_PERIOD()](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/vendor/compound/ICompoundTimelock.sol#L41) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/vendor/compound/ICompoundTimelock.sol#L41


 - [ ] ID-63
Function [GovernorSequentialProposalIdUpgradeable.__GovernorSequentialProposalId_init()](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L49-L51) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L49-L51


 - [ ] ID-64
Function [GovernorCountingFractionalUpgradeable.COUNTING_MODE()](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L79-L81) is not in mixedCase

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L79-L81


 - [ ] ID-65
Parameter [CompoundGovernor.isAllowedProposer(address)._account](contracts/CompoundGovernor.sol#L512) is not in mixedCase

contracts/CompoundGovernor.sol#L512


 - [ ] ID-66
Function [GovernorCountingSimpleUpgradeable.__GovernorCountingSimple_init()](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L44-L45) is not in mixedCase

contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L44-L45


 - [ ] ID-67
Parameter [GovernorSequentialProposalIdUpgradeable.hashProposal(address[],uint256[],bytes[],bytes32)._values](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L60) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L60


 - [ ] ID-68
Parameter [CompoundGovernor.propose(address[],uint256[],bytes[],string)._values](contracts/CompoundGovernor.sol#L290) is not in mixedCase

contracts/CompoundGovernor.sol#L290


 - [ ] ID-69
Parameter [GovernorSequentialProposalIdUpgradeable.execute(uint256)._proposalId](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L123) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L123


 - [ ] ID-70
Parameter [GovernorSequentialProposalIdUpgradeable.cancel(uint256)._proposalId](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L133) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L133


 - [ ] ID-71
Parameter [CompoundGovernor.cancel(address[],uint256[],bytes[],bytes32)._targets](contracts/CompoundGovernor.sol#L354) is not in mixedCase

contracts/CompoundGovernor.sol#L354


 - [ ] ID-72
Parameter [GovernorSequentialProposalIdUpgradeable.hashProposal(address[],uint256[],bytes[],bytes32)._descriptionHash](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L62) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L62


 - [ ] ID-73
Function [GovernorPreventLateQuorumUpgradeable.__GovernorPreventLateQuorum_init(uint48)](contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L48-L50) is not in mixedCase

contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L48-L50


 - [ ] ID-74
Parameter [CompoundGovernor.addProposer(address)._newProposer](contracts/CompoundGovernor.sol#L430) is not in mixedCase

contracts/CompoundGovernor.sol#L430


 - [ ] ID-75
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._proposalGuardian](contracts/CompoundGovernor.sol#L204) is not in mixedCase

contracts/CompoundGovernor.sol#L204


 - [ ] ID-76
Function [IComp.DELEGATION_TYPEHASH()](contracts/interfaces/IComp.sol#L15) is not in mixedCase

contracts/interfaces/IComp.sol#L15


 - [ ] ID-77
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._initialProposalThreshold](contracts/CompoundGovernor.sol#L198) is not in mixedCase

contracts/CompoundGovernor.sol#L198


 - [ ] ID-78
Function [EIP712Upgradeable.__EIP712_init(string,string)](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L68-L70) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L68-L70


 - [ ] ID-79
Parameter [CompoundGovernor.hashProposal(address[],uint256[],bytes[],bytes32)._values](contracts/CompoundGovernor.sol#L275) is not in mixedCase

contracts/CompoundGovernor.sol#L275


 - [ ] ID-80
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._whitelistGuardian](contracts/CompoundGovernor.sol#L203) is not in mixedCase

contracts/CompoundGovernor.sol#L203


 - [ ] ID-81
Function [GovernorVotesCompUpgradeable.CLOCK_MODE()](contracts/extensions/GovernorVotesCompUpgradeable.sol#L58-L60) is not in mixedCase

contracts/extensions/GovernorVotesCompUpgradeable.sol#L58-L60


 - [ ] ID-82
Constant [GovernorSettingsUpgradeable.GovernorSettingsStorageLocation](contracts/extensions/GovernorSettingsUpgradeable.sol#L25) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorSettingsUpgradeable.sol#L25


 - [ ] ID-83
Function [IERC6372.CLOCK_MODE()](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC6372.sol#L16) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC6372.sol#L16


 - [ ] ID-84
Function [ICompoundTimelock.MINIMUM_DELAY()](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/vendor/compound/ICompoundTimelock.sol#L44) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/vendor/compound/ICompoundTimelock.sol#L44


 - [ ] ID-85
Parameter [GovernorSequentialProposalIdUpgradeable.proposalDetails(uint256)._proposalId](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L142) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L142


 - [ ] ID-86
Function [GovernorSequentialProposalIdUpgradeable.__GovernorSequentialProposalId_init_unchained()](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L53-L56) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L53-L56


 - [ ] ID-87
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._initialVotingPeriod](contracts/CompoundGovernor.sol#L197) is not in mixedCase

contracts/CompoundGovernor.sol#L197


 - [ ] ID-88
Parameter [CompoundGovernor.setWhitelistGuardian(address)._newWhitelistGuardian](contracts/CompoundGovernor.sol#L556) is not in mixedCase

contracts/CompoundGovernor.sol#L556


 - [ ] ID-89
Parameter [CompoundGovernor.batchWhitelist(address[])._initProposers](contracts/CompoundGovernor.sol#L223) is not in mixedCase

contracts/CompoundGovernor.sol#L223


 - [ ] ID-90
Parameter [CompoundGovernor.propose(address[],uint256[],bytes[],string)._description](contracts/CompoundGovernor.sol#L292) is not in mixedCase

contracts/CompoundGovernor.sol#L292


 - [ ] ID-91
Parameter [GovernorSettableFixedQuorumUpgradeable.__GovernorSettableFixedQuorum_init_unchained(uint256)._initialQuorum](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L43) is not in mixedCase

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L43


 - [ ] ID-92
Constant [GovernorUpgradeable.GovernorStorageLocation](contracts/extensions/GovernorUpgradeable.sol#L65) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorUpgradeable.sol#L65


 - [ ] ID-93
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._initialVoteExtension](contracts/CompoundGovernor.sol#L202) is not in mixedCase

contracts/CompoundGovernor.sol#L202


 - [ ] ID-94
Function [GovernorSettableFixedQuorumUpgradeable.__GovernorSettableFixedQuorum_init_unchained(uint256)](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L43-L45) is not in mixedCase

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L43-L45


 - [ ] ID-95
Parameter [GovernorVotesCompUpgradeable.__GovernorVotesComp_init_unchained(IComp)._tokenAddress](contracts/extensions/GovernorVotesCompUpgradeable.sol#L34) is not in mixedCase

contracts/extensions/GovernorVotesCompUpgradeable.sol#L34


 - [ ] ID-96
Parameter [CompoundGovernor.setWhitelistAccountExpiration(address,uint256)._account](contracts/CompoundGovernor.sol#L394) is not in mixedCase

contracts/CompoundGovernor.sol#L394


 - [ ] ID-97
Constant [GovernorCountingSimpleUpgradeable.GovernorCountingSimpleStorageLocation](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L36) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L36


 - [ ] ID-98
Constant [GovernorCountingFractionalUpgradeable.GovernorCountingFractionalStorageLocation](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L57) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L57


 - [ ] ID-99
Function [IComp.DOMAIN_TYPEHASH()](contracts/interfaces/IComp.sol#L16) is not in mixedCase

contracts/interfaces/IComp.sol#L16


 - [ ] ID-100
Function [GovernorSettableFixedQuorumUpgradeable.__GovernorSettableFixedQuorum_init(uint256)](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L39-L41) is not in mixedCase

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L39-L41


 - [ ] ID-101
Parameter [CompoundGovernor.setProposalGuardian(CompoundGovernor.ProposalGuardian)._newProposalGuardian](contracts/CompoundGovernor.sol#L564) is not in mixedCase

contracts/CompoundGovernor.sol#L564


 - [ ] ID-102
Parameter [CompoundGovernor.state(uint256)._proposalId](contracts/CompoundGovernor.sol#L697) is not in mixedCase

contracts/CompoundGovernor.sol#L697


 - [ ] ID-103
Parameter [CompoundGovernor.proposalDeadline(uint256)._proposalId](contracts/CompoundGovernor.sol#L664) is not in mixedCase

contracts/CompoundGovernor.sol#L664


 - [ ] ID-104
Constant [GovernorTimelockCompoundUpgradeable.GovernorTimelockCompoundStorageLocation](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L31) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L31


 - [ ] ID-105
Constant [EIP712Upgradeable.EIP712StorageLocation](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L48) is not in UPPER_CASE_WITH_UNDERSCORES

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L48


 - [ ] ID-106
Parameter [GovernorVotesCompUpgradeable.__GovernorVotesComp_init(IComp)._tokenAddress](contracts/extensions/GovernorVotesCompUpgradeable.sol#L30) is not in mixedCase

contracts/extensions/GovernorVotesCompUpgradeable.sol#L30


 - [ ] ID-107
Function [GovernorUpgradeable.__Governor_init(string)](contracts/extensions/GovernorUpgradeable.sol#L91-L94) is not in mixedCase

contracts/extensions/GovernorUpgradeable.sol#L91-L94


 - [ ] ID-108
Function [ERC165Upgradeable.__ERC165_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L25-L26) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L25-L26


 - [ ] ID-109
Function [ContextUpgradeable.__Context_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L21-L22) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L21-L22


 - [ ] ID-110
Function [EIP712Upgradeable._EIP712VersionHash()](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L194-L209) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L194-L209


 - [ ] ID-111
Constant [GovernorPreventLateQuorumUpgradeable.GovernorPreventLateQuorumStorageLocation](contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L29) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L29


 - [ ] ID-112
Function [GovernorTimelockCompoundUpgradeable.__GovernorTimelockCompound_init(ICompoundTimelock)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L47-L49) is not in mixedCase

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L47-L49


 - [ ] ID-113
Function [GovernorTimelockCompoundUpgradeable.__acceptAdmin()](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L167-L170) is not in mixedCase

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L167-L170


 - [ ] ID-114
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._compAddress](contracts/CompoundGovernor.sol#L199) is not in mixedCase

contracts/CompoundGovernor.sol#L199


 - [ ] ID-115
Parameter [CompoundGovernor.removeProposer(address)._proposer](contracts/CompoundGovernor.sol#L471) is not in mixedCase

contracts/CompoundGovernor.sol#L471


 - [ ] ID-116
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._initialVotingDelay](contracts/CompoundGovernor.sol#L196) is not in mixedCase

contracts/CompoundGovernor.sol#L196


 - [ ] ID-117
Function [NoncesUpgradeable.__Nonces_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L29-L30) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L29-L30


 - [ ] ID-118
Function [GovernorTimelockCompoundUpgradeable.__GovernorTimelockCompound_init_unchained(ICompoundTimelock)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L51-L53) is not in mixedCase

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L51-L53


 - [ ] ID-119
Function [TimelockInterface.GRACE_PERIOD()](contracts/GovernorBravoInterfaces.sol#L199) is not in mixedCase

contracts/GovernorBravoInterfaces.sol#L199


 - [ ] ID-120
Function [NoncesUpgradeable.__Nonces_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L32-L33) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L32-L33


 - [ ] ID-121
Function [EIP712Upgradeable._EIP712NameHash()](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L172-L187) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L172-L187


 - [ ] ID-122
Function [GovernorVotesCompUpgradeable.__GovernorVotesComp_init(IComp)](contracts/extensions/GovernorVotesCompUpgradeable.sol#L30-L32) is not in mixedCase

contracts/extensions/GovernorVotesCompUpgradeable.sol#L30-L32


 - [ ] ID-123
Function [EIP712Upgradeable._EIP712Version()](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L162-L165) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L162-L165


 - [ ] ID-124
Parameter [CompoundGovernor.cancel(address[],uint256[],bytes[],bytes32)._descriptionHash](contracts/CompoundGovernor.sol#L357) is not in mixedCase

contracts/CompoundGovernor.sol#L357


 - [ ] ID-125
Function [GovernorCountingFractionalUpgradeable.__GovernorCountingFractional_init_unchained()](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L73-L74) is not in mixedCase

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L73-L74


 - [ ] ID-126
Function [GovernorPreventLateQuorumUpgradeable.__GovernorPreventLateQuorum_init_unchained(uint48)](contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L52-L54) is not in mixedCase

contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L52-L54


 - [ ] ID-127
Function [EIP712Upgradeable._EIP712Name()](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L151-L154) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L151-L154


 - [ ] ID-128
Parameter [GovernorSettableFixedQuorumUpgradeable.__GovernorSettableFixedQuorum_init(uint256)._initialQuorum](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L39) is not in mixedCase

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L39


 - [ ] ID-129
Function [GovernorUpgradeable.__Governor_init_unchained(string)](contracts/extensions/GovernorUpgradeable.sol#L96-L99) is not in mixedCase

contracts/extensions/GovernorUpgradeable.sol#L96-L99


 - [ ] ID-130
Parameter [GovernorSequentialProposalIdUpgradeable.queue(uint256)._proposalId](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L113) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L113


 - [ ] ID-131
Function [GovernorVotesCompUpgradeable.__GovernorVotesComp_init_unchained(IComp)](contracts/extensions/GovernorVotesCompUpgradeable.sol#L34-L37) is not in mixedCase

contracts/extensions/GovernorVotesCompUpgradeable.sol#L34-L37


 - [ ] ID-132
Parameter [CompoundGovernor.cancel(uint256)._proposalId](contracts/CompoundGovernor.sol#L379) is not in mixedCase

contracts/CompoundGovernor.sol#L379


 - [ ] ID-133
Function [GovernorSettingsUpgradeable.__GovernorSettings_init_unchained(uint48,uint32,uint256)](contracts/extensions/GovernorSettingsUpgradeable.sol#L44-L48) is not in mixedCase

contracts/extensions/GovernorSettingsUpgradeable.sol#L44-L48


 - [ ] ID-134
Parameter [GovernorSequentialProposalIdUpgradeable.hashProposal(address[],uint256[],bytes[],bytes32)._targets](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L59) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L59


 - [ ] ID-135
Constant [GovernorVotesCompUpgradeable.GovernorVotesCompStorageLocation](contracts/extensions/GovernorVotesCompUpgradeable.sol#L21-L22) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorVotesCompUpgradeable.sol#L21-L22


 - [ ] ID-136
Function [GovernorUpgradeable.CLOCK_MODE()](contracts/extensions/GovernorUpgradeable.sol#L869) is not in mixedCase

contracts/extensions/GovernorUpgradeable.sol#L869


 - [ ] ID-137
Parameter [GovernorSequentialProposalIdUpgradeable.hashProposal(address[],uint256[],bytes[],bytes32)._calldatas](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L61) is not in mixedCase

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L61


 - [ ] ID-138
Constant [GovernorSettableFixedQuorumUpgradeable.GovernorSettableFixedQuorumStorageLocation](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L23-L24) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L23-L24


 - [ ] ID-139
Function [GovernorCountingSimpleUpgradeable.__GovernorCountingSimple_init_unchained()](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L47-L48) is not in mixedCase

contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L47-L48


 - [ ] ID-140
Parameter [CompoundGovernor.cancel(address[],uint256[],bytes[],bytes32)._calldatas](contracts/CompoundGovernor.sol#L356) is not in mixedCase

contracts/CompoundGovernor.sol#L356


 - [ ] ID-141
Function [GovernorCountingSimpleUpgradeable.COUNTING_MODE()](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L53-L55) is not in mixedCase

contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L53-L55


 - [ ] ID-142
Parameter [CompoundGovernor.hashProposal(address[],uint256[],bytes[],bytes32)._calldatas](contracts/CompoundGovernor.sol#L276) is not in mixedCase

contracts/CompoundGovernor.sol#L276


 - [ ] ID-143
Function [CompoundGovernor.COUNTING_MODE()](contracts/CompoundGovernor.sol#L708-L715) is not in mixedCase

contracts/CompoundGovernor.sol#L708-L715


 - [ ] ID-144
Parameter [CompoundGovernor.setWhitelistAccountExpiration(address,uint256)._expiration](contracts/CompoundGovernor.sol#L394) is not in mixedCase

contracts/CompoundGovernor.sol#L394


 - [ ] ID-145
Constant [CompoundGovernor.compoundGovernorBravo](contracts/CompoundGovernor.sol#L141-L142) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/CompoundGovernor.sol#L141-L142


 - [ ] ID-146
Function [ICompoundTimelock.MAXIMUM_DELAY()](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/vendor/compound/ICompoundTimelock.sol#L47) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/vendor/compound/ICompoundTimelock.sol#L47


 - [ ] ID-147
Function [ContextUpgradeable.__Context_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L18-L19) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L18-L19


 - [ ] ID-148
Parameter [GovernorSettableFixedQuorumUpgradeable.quorum(uint256)._voteStart](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L56) is not in mixedCase

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L56


 - [ ] ID-149
Parameter [CompoundGovernor.propose(address[],uint256[],bytes[],string)._targets](contracts/CompoundGovernor.sol#L289) is not in mixedCase

contracts/CompoundGovernor.sol#L289


 - [ ] ID-150
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._quorumVotes](contracts/CompoundGovernor.sol#L200) is not in mixedCase

contracts/CompoundGovernor.sol#L200


 - [ ] ID-151
Function [ERC165Upgradeable.__ERC165_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L22-L23) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L22-L23


 - [ ] ID-152
Function [IGovernor.COUNTING_MODE()](contracts/extensions/IGovernor.sol#L204) is not in mixedCase

contracts/extensions/IGovernor.sol#L204


 - [ ] ID-153
Function [GovernorSettingsUpgradeable.__GovernorSettings_init(uint48,uint32,uint256)](contracts/extensions/GovernorSettingsUpgradeable.sol#L40-L42) is not in mixedCase

contracts/extensions/GovernorSettingsUpgradeable.sol#L40-L42


 - [ ] ID-154
Constant [GovernorSequentialProposalIdUpgradeable.GovernorSequentialProposalIdStorageLocation](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L36-L37) is not in UPPER_CASE_WITH_UNDERSCORES

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L36-L37


 - [ ] ID-155
Function [GovernorCountingFractionalUpgradeable.__GovernorCountingFractional_init()](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L70-L71) is not in mixedCase

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L70-L71


 - [ ] ID-156
Parameter [CompoundGovernor.hashProposal(address[],uint256[],bytes[],bytes32)._targets](contracts/CompoundGovernor.sol#L274) is not in mixedCase

contracts/CompoundGovernor.sol#L274


 - [ ] ID-157
Parameter [CompoundGovernor.initialize(uint48,uint32,uint256,IComp,uint256,ICompoundTimelock,uint48,address,CompoundGovernor.ProposalGuardian)._timelockAddress](contracts/CompoundGovernor.sol#L201) is not in mixedCase

contracts/CompoundGovernor.sol#L201


 - [ ] ID-158
Function [EIP712Upgradeable.__EIP712_init_unchained(string,string)](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L72-L80) is not in mixedCase

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L72-L80


 - [ ] ID-159
Parameter [CompoundGovernor.propose(address[],uint256[],bytes[],string)._calldatas](contracts/CompoundGovernor.sol#L291) is not in mixedCase

contracts/CompoundGovernor.sol#L291


 - [ ] ID-160
Parameter [CompoundGovernor.cancel(address[],uint256[],bytes[],bytes32)._values](contracts/CompoundGovernor.sol#L355) is not in mixedCase

contracts/CompoundGovernor.sol#L355


 - [ ] ID-161
Parameter [GovernorSettableFixedQuorumUpgradeable.setQuorum(uint256)._amount](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L50) is not in mixedCase

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L50


## locked-ether
Impact: Medium
Confidence: High
 - [ ] ID-162
Contract locking ether found:
	Contract [GovernorBravoDelegate](contracts/GovernorBravoDelegate.sol#L13-L652) has payable functions:
	 - [GovernorBravoDelegate.execute(uint256)](contracts/GovernorBravoDelegate.sol#L278-L291)
	But does not have a function to withdraw the ether

contracts/GovernorBravoDelegate.sol#L13-L652


## reentrancy-no-eth
Impact: Medium
Confidence: Medium
 - [ ] ID-163
Reentrancy in [GovernorBravoDelegate._initiate(address)](contracts/GovernorBravoDelegate.sol#L593-L599):
	External calls:
	- [proposalCount = GovernorAlphaInterface(governorAlpha).proposalCount()](contracts/GovernorBravoDelegate.sol#L596)
	State variables written after the call(s):
	- [initialProposalId = proposalCount](contracts/GovernorBravoDelegate.sol#L597)
	[GovernorBravoDelegateStorageV1.initialProposalId](contracts/GovernorBravoInterfaces.sol#L87) can be used in cross function reentrancies:
	- [GovernorBravoDelegate._initiate(address)](contracts/GovernorBravoDelegate.sol#L593-L599)
	- [GovernorBravoDelegateStorageV1.initialProposalId](contracts/GovernorBravoInterfaces.sol#L87)
	- [GovernorBravoDelegate.proposeInternal(address,address[],uint256[],string[],bytes[],string)](contracts/GovernorBravoDelegate.sol#L174-L238)
	- [GovernorBravoDelegate.state(uint256)](contracts/GovernorBravoDelegate.sol#L367-L389)

contracts/GovernorBravoDelegate.sol#L593-L599


 - [ ] ID-164
Reentrancy in [GovernorBravoDelegate.queue(uint256)](contracts/GovernorBravoDelegate.sol#L244-L258):
	External calls:
	- [queueOrRevertInternal(proposal.targets[i],proposal.values[i],proposal.signatures[i],proposal.calldatas[i],eta)](contracts/GovernorBravoDelegate.sol#L252-L254)
		- [timelock.queueTransaction(target,value,signature,data,eta)](contracts/GovernorBravoDelegate.sol#L271)
	State variables written after the call(s):
	- [proposal.eta = eta](contracts/GovernorBravoDelegate.sol#L256)
	[GovernorBravoDelegateStorageV1.proposals](contracts/GovernorBravoInterfaces.sol#L99) can be used in cross function reentrancies:
	- [GovernorBravoDelegate.cancel(uint256)](contracts/GovernorBravoDelegate.sol#L298-L328)
	- [GovernorBravoDelegate.castVoteInternal(address,uint256,uint8)](contracts/GovernorBravoDelegate.sol#L461-L482)
	- [GovernorBravoDelegate.execute(uint256)](contracts/GovernorBravoDelegate.sol#L278-L291)
	- [GovernorBravoDelegate.getActions(uint256)](contracts/GovernorBravoDelegate.sol#L338-L350)
	- [GovernorBravoDelegate.getReceipt(uint256,address)](contracts/GovernorBravoDelegate.sol#L358-L360)
	- [GovernorBravoDelegateStorageV1.proposals](contracts/GovernorBravoInterfaces.sol#L99)
	- [GovernorBravoDelegate.proposeInternal(address,address[],uint256[],string[],bytes[],string)](contracts/GovernorBravoDelegate.sol#L174-L238)
	- [GovernorBravoDelegate.queue(uint256)](contracts/GovernorBravoDelegate.sol#L244-L258)
	- [GovernorBravoDelegate.state(uint256)](contracts/GovernorBravoDelegate.sol#L367-L389)

contracts/GovernorBravoDelegate.sol#L244-L258


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-165
[GovernorBravoDelegate.execute(uint256)](contracts/GovernorBravoDelegate.sol#L278-L291) ignores return value by [timelock.executeTransaction(proposal.targets[i],proposal.values[i],proposal.signatures[i],proposal.calldatas[i],proposal.eta)](contracts/GovernorBravoDelegate.sol#L286-L288)

contracts/GovernorBravoDelegate.sol#L278-L291


 - [ ] ID-166
[GovernorBravoDelegate.queueOrRevertInternal(address,uint256,string,bytes,uint256)](contracts/GovernorBravoDelegate.sol#L260-L272) ignores return value by [timelock.queueTransaction(target,value,signature,data,eta)](contracts/GovernorBravoDelegate.sol#L271)

contracts/GovernorBravoDelegate.sol#L260-L272


 - [ ] ID-167
[CompoundGovernor.addProposer(address)](contracts/CompoundGovernor.sol#L430-L464) ignores return value by [allowedProposers.add(_newProposer)](contracts/CompoundGovernor.sol#L462)

contracts/CompoundGovernor.sol#L430-L464


 - [ ] ID-168
[Time.get(Time.Delay)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/types/Time.sol#L93-L96) ignores return value by [(delay,None,None) = self.getFull()](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/types/Time.sol#L94)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/types/Time.sol#L93-L96


 - [ ] ID-169
[GovernorTimelockCompoundUpgradeable._queueOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107) ignores return value by [$._timelock.queueTransaction(targets[i],values[i],,calldatas[i],etaSeconds)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L103)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107


 - [ ] ID-170
[CompoundGovernor._setProposalGuardian(CompoundGovernor.ProposalGuardian)](contracts/CompoundGovernor.sol#L584-L599) ignores return value by [allowedProposers.add(newProposalGuardian)](contracts/CompoundGovernor.sol#L595)

contracts/CompoundGovernor.sol#L584-L599


 - [ ] ID-171
[GovernorSettableFixedQuorumUpgradeable._setQuorum(uint256)](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L63-L68) ignores return value by [$._quorumCheckpoints.push(_timepoint,SafeCast.toUint208(_amount))](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L67)

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L63-L68


 - [ ] ID-172
[GovernorUpgradeable.relay(address,uint256,bytes)](contracts/extensions/GovernorUpgradeable.sol#L693-L696) ignores return value by [Address.verifyCallResult(success,returndata)](contracts/extensions/GovernorUpgradeable.sol#L695)

contracts/extensions/GovernorUpgradeable.sol#L693-L696


 - [ ] ID-173
[CompoundGovernor._setProposalGuardian(CompoundGovernor.ProposalGuardian)](contracts/CompoundGovernor.sol#L584-L599) ignores return value by [allowedProposers.remove(currentProposalGuardian)](contracts/CompoundGovernor.sol#L594)

contracts/CompoundGovernor.sol#L584-L599


 - [ ] ID-174
[CompoundGovernor.removeProposer(address)](contracts/CompoundGovernor.sol#L471-L494) ignores return value by [allowedProposers.remove(_proposer)](contracts/CompoundGovernor.sol#L492)

contracts/CompoundGovernor.sol#L471-L494


 - [ ] ID-175
[GovernorCountingFractionalUpgradeable._countVote(uint256,address,uint8,uint256,bytes)](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L158-L219) ignores return value by [(None,remainingWeight) = totalWeight.trySub(usedVotes(proposalId,account))](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L167)

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L158-L219


 - [ ] ID-176
[SignatureChecker.isValidSignatureNow(address,bytes32,bytes)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol#L22-L29) ignores return value by [(recovered,err,None) = ECDSA.tryRecover(hash,signature)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol#L24)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol#L22-L29


 - [ ] ID-177
[GovernorTimelockCompoundUpgradeable._executeOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L113-L129) ignores return value by [$._timelock.executeTransaction(targets[i],values[i],,calldatas[i],etaSeconds)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L127)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L113-L129


 - [ ] ID-178
[GovernorUpgradeable._executeOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorUpgradeable.sol#L471-L482) ignores return value by [Address.verifyCallResult(success,returndata)](contracts/extensions/GovernorUpgradeable.sol#L480)

contracts/extensions/GovernorUpgradeable.sol#L471-L482


## shadowing-local
Impact: Low
Confidence: High
 - [ ] ID-179
[GovernorBravoDelegate.cancel(uint256).proposalGuardian](contracts/GovernorBravoDelegate.sol#L304-L305) shadows:
	- [GovernorBravoDelegateStorageV3.proposalGuardian](contracts/GovernorBravoInterfaces.sol#L194) (state variable)

contracts/GovernorBravoDelegate.sol#L304-L305


## events-maths
Impact: Low
Confidence: Medium
 - [ ] ID-180
[GovernorBravoDelegate._initiate(address)](contracts/GovernorBravoDelegate.sol#L593-L599) should emit an event for: 
	- [proposalCount = GovernorAlphaInterface(governorAlpha).proposalCount()](contracts/GovernorBravoDelegate.sol#L596) 
	- [initialProposalId = proposalCount](contracts/GovernorBravoDelegate.sol#L597) 

contracts/GovernorBravoDelegate.sol#L593-L599


 - [ ] ID-181
[GovernorBravoDelegate.initialize(address,address,uint256,uint256,uint256)](contracts/GovernorBravoDelegate.sol#L66-L95) should emit an event for: 
	- [votingPeriod = votingPeriod_](contracts/GovernorBravoDelegate.sol#L92) 
	- [votingDelay = votingDelay_](contracts/GovernorBravoDelegate.sol#L93) 
	- [proposalThreshold = proposalThreshold_](contracts/GovernorBravoDelegate.sol#L94) 

contracts/GovernorBravoDelegate.sol#L66-L95


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-182
[GovernorBravoDelegate.queueOrRevertInternal(address,uint256,string,bytes,uint256)](contracts/GovernorBravoDelegate.sol#L260-L272) has external calls inside a loop: [require(bool,string)(! timelock.queuedTransactions(keccak256(bytes)(abi.encode(target,value,signature,data,eta))),GovernorBravo::queueOrRevertInternal: identical proposal action already queued at eta)](contracts/GovernorBravoDelegate.sol#L267-L270)
	Calls stack containing the loop:
		GovernorBravoDelegate.queue(uint256)

contracts/GovernorBravoDelegate.sol#L260-L272


 - [ ] ID-183
[GovernorBravoDelegate.queueOrRevertInternal(address,uint256,string,bytes,uint256)](contracts/GovernorBravoDelegate.sol#L260-L272) has external calls inside a loop: [timelock.queueTransaction(target,value,signature,data,eta)](contracts/GovernorBravoDelegate.sol#L271)
	Calls stack containing the loop:
		GovernorBravoDelegate.queue(uint256)

contracts/GovernorBravoDelegate.sol#L260-L272


 - [ ] ID-184
[GovernorBravoDelegate.cancel(uint256)](contracts/GovernorBravoDelegate.sol#L298-L328) has external calls inside a loop: [timelock.cancelTransaction(proposal.targets[i],proposal.values[i],proposal.signatures[i],proposal.calldatas[i],proposal.eta)](contracts/GovernorBravoDelegate.sol#L322-L324)

contracts/GovernorBravoDelegate.sol#L298-L328


 - [ ] ID-185
[GovernorBravoDelegate.execute(uint256)](contracts/GovernorBravoDelegate.sol#L278-L291) has external calls inside a loop: [timelock.executeTransaction(proposal.targets[i],proposal.values[i],proposal.signatures[i],proposal.calldatas[i],proposal.eta)](contracts/GovernorBravoDelegate.sol#L286-L288)

contracts/GovernorBravoDelegate.sol#L278-L291


 - [ ] ID-186
[GovernorTimelockCompoundUpgradeable._queueOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107) has external calls inside a loop: [$._timelock.queueTransaction(targets[i],values[i],,calldatas[i],etaSeconds)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L103)
	Calls stack containing the loop:
		GovernorUpgradeable.queue(address[],uint256[],bytes[],bytes32)
		CompoundGovernor._queueOperations(uint256,address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107


 - [ ] ID-187
[GovernorTimelockCompoundUpgradeable._cancel(address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L135-L153) has external calls inside a loop: [$._timelock.cancelTransaction(targets[i],values[i],,calldatas[i],etaSeconds)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L148)
	Calls stack containing the loop:
		CompoundGovernor.cancel(uint256)
		CompoundGovernor.cancel(address[],uint256[],bytes[],bytes32)
		CompoundGovernor._cancel(address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L135-L153


 - [ ] ID-188
[GovernorTimelockCompoundUpgradeable._cancel(address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L135-L153) has external calls inside a loop: [$._timelock.cancelTransaction(targets[i],values[i],,calldatas[i],etaSeconds)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L148)
	Calls stack containing the loop:
		CompoundGovernor.cancel(address[],uint256[],bytes[],bytes32)
		CompoundGovernor._cancel(address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L135-L153


 - [ ] ID-189
[GovernorUpgradeable._executeOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorUpgradeable.sol#L471-L482) has external calls inside a loop: [(success,returndata) = targets[i].call{value: values[i]}(calldatas[i])](contracts/extensions/GovernorUpgradeable.sol#L479)
	Calls stack containing the loop:
		GovernorUpgradeable.execute(address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorUpgradeable.sol#L471-L482


 - [ ] ID-190
[GovernorTimelockCompoundUpgradeable._queueOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107) has external calls inside a loop: [$._timelock.queuedTransactions(keccak256(bytes)(abi.encode(targets[i],values[i],,calldatas[i],etaSeconds)))](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L99)
	Calls stack containing the loop:
		GovernorSequentialProposalIdUpgradeable.queue(uint256)
		GovernorUpgradeable.queue(address[],uint256[],bytes[],bytes32)
		CompoundGovernor._queueOperations(uint256,address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107


 - [ ] ID-191
[GovernorTimelockCompoundUpgradeable._executeOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L113-L129) has external calls inside a loop: [$._timelock.executeTransaction(targets[i],values[i],,calldatas[i],etaSeconds)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L127)
	Calls stack containing the loop:
		GovernorUpgradeable.execute(address[],uint256[],bytes[],bytes32)
		CompoundGovernor._executeOperations(uint256,address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L113-L129


 - [ ] ID-192
[GovernorTimelockCompoundUpgradeable._executeOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L113-L129) has external calls inside a loop: [$._timelock.executeTransaction(targets[i],values[i],,calldatas[i],etaSeconds)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L127)
	Calls stack containing the loop:
		GovernorSequentialProposalIdUpgradeable.execute(uint256)
		GovernorUpgradeable.execute(address[],uint256[],bytes[],bytes32)
		CompoundGovernor._executeOperations(uint256,address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L113-L129


 - [ ] ID-193
[GovernorTimelockCompoundUpgradeable._queueOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107) has external calls inside a loop: [$._timelock.queuedTransactions(keccak256(bytes)(abi.encode(targets[i],values[i],,calldatas[i],etaSeconds)))](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L99)
	Calls stack containing the loop:
		GovernorUpgradeable.queue(address[],uint256[],bytes[],bytes32)
		CompoundGovernor._queueOperations(uint256,address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107


 - [ ] ID-194
[GovernorTimelockCompoundUpgradeable._queueOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107) has external calls inside a loop: [$._timelock.queueTransaction(targets[i],values[i],,calldatas[i],etaSeconds)](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L103)
	Calls stack containing the loop:
		GovernorSequentialProposalIdUpgradeable.queue(uint256)
		GovernorUpgradeable.queue(address[],uint256[],bytes[],bytes32)
		CompoundGovernor._queueOperations(uint256,address[],uint256[],bytes[],bytes32)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L87-L107


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-195
[GovernorBravoDelegate.getChainIdInternal()](contracts/GovernorBravoDelegate.sol#L645-L651) uses assembly
	- [INLINE ASM](contracts/GovernorBravoDelegate.sol#L647-L649)

contracts/GovernorBravoDelegate.sol#L645-L651


 - [ ] ID-196
[Comp.getChainId()](contracts/Comp.sol#L296-L300) uses assembly
	- [INLINE ASM](contracts/Comp.sol#L298)

contracts/Comp.sol#L296-L300


 - [ ] ID-197
[GovernorBravoDelegator.delegateTo(address,bytes)](contracts/GovernorBravoDelegator.sol#L65-L72) uses assembly
	- [INLINE ASM](contracts/GovernorBravoDelegator.sol#L67-L71)

contracts/GovernorBravoDelegator.sol#L65-L72


 - [ ] ID-198
[GovernorBravoDelegator.fallback()](contracts/GovernorBravoDelegator.sol#L79-L95) uses assembly
	- [INLINE ASM](contracts/GovernorBravoDelegator.sol#L83-L94)

contracts/GovernorBravoDelegator.sol#L79-L95


 - [ ] ID-199
[SafeCast.toUint(bool)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#L1157-L1161) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#L1158-L1160)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#L1157-L1161


 - [ ] ID-200
[Math.tryModExp(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L337-L361) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L339-L360)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L337-L361


 - [ ] ID-201
[Strings.toChecksumHexString(address)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L90-L108) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L95-L97)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L90-L108


 - [ ] ID-202
[EIP712Upgradeable._getEIP712Storage()](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L50-L54) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L51-L53)

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L50-L54


 - [ ] ID-203
[GovernorSettingsUpgradeable._getGovernorSettingsStorage()](contracts/extensions/GovernorSettingsUpgradeable.sol#L27-L31) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorSettingsUpgradeable.sol#L28-L30)

contracts/extensions/GovernorSettingsUpgradeable.sol#L27-L31


 - [ ] ID-204
[GovernorVotesCompUpgradeable._getGovernorVotesCompStorage()](contracts/extensions/GovernorVotesCompUpgradeable.sol#L24-L28) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorVotesCompUpgradeable.sol#L25-L27)

contracts/extensions/GovernorVotesCompUpgradeable.sol#L24-L28


 - [ ] ID-205
[Checkpoints._unsafeAccess(Checkpoints.Checkpoint160[],uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L621-L629) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L625-L628)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L621-L629


 - [ ] ID-206
[EnumerableSet.values(EnumerableSet.AddressSet)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L292-L301) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L296-L298)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L292-L301


 - [ ] ID-207
[Math.tryModExp(bytes,bytes,bytes)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L377-L399) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L389-L398)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L377-L399


 - [ ] ID-208
[Strings.toString(uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L24-L42) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L29-L31)
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L34-L36)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L24-L42


 - [ ] ID-209
[GovernorSettableFixedQuorumUpgradeable._getGovernorSettableFixedQuorumStorage()](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L26-L34) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L31-L33)

contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L26-L34


 - [ ] ID-210
[GovernorUpgradeable._getGovernorStorage()](contracts/extensions/GovernorUpgradeable.sol#L67-L71) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorUpgradeable.sol#L68-L70)

contracts/extensions/GovernorUpgradeable.sol#L67-L71


 - [ ] ID-211
[GovernorSequentialProposalIdUpgradeable._getGovernorSequentialProposalIdStorage()](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L39-L47) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L44-L46)

contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L39-L47


 - [ ] ID-212
[Checkpoints._unsafeAccess(Checkpoints.Checkpoint224[],uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L215-L223) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L219-L222)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L215-L223


 - [ ] ID-213
[EnumerableSet.values(EnumerableSet.UintSet)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L365-L374) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L369-L371)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L365-L374


 - [ ] ID-214
[GovernorCountingSimpleUpgradeable._getGovernorCountingSimpleStorage()](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L38-L42) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L39-L41)

contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L38-L42


 - [ ] ID-215
[NoncesUpgradeable._getNoncesStorage()](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L23-L27) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L24-L26)

lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L23-L27


 - [ ] ID-216
[Address._revert(bytes)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L138-L149) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L142-L145)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L138-L149


 - [ ] ID-217
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L151-L154)
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L175-L182)
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L188-L197)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


 - [ ] ID-218
[GovernorCountingFractionalUpgradeable._countVote(uint256,address,uint8,uint256,bytes)](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L158-L219) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L196-L201)

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L158-L219


 - [ ] ID-219
[Initializable._getInitializableStorage()](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L223-L227) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L224-L226)

lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L223-L227


 - [ ] ID-220
[GovernorCountingFractionalUpgradeable._getGovernorCountingFractionalStorage()](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L59-L63) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L60-L62)

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L59-L63


 - [ ] ID-221
[ECDSA.tryRecover(bytes32,bytes)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#L56-L75) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#L66-L70)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#L56-L75


 - [ ] ID-222
[GovernorPreventLateQuorumUpgradeable._getGovernorPreventLateQuorumStorage()](contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L31-L35) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L32-L34)

contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L31-L35


 - [ ] ID-223
[GovernorTimelockCompoundUpgradeable._getGovernorTimelockCompoundStorage()](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L33-L37) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L34-L36)

contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L33-L37


 - [ ] ID-224
[EnumerableSet.values(EnumerableSet.Bytes32Set)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L219-L228) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L223-L225)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L219-L228


 - [ ] ID-225
[Checkpoints._unsafeAccess(Checkpoints.Checkpoint208[],uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L418-L426) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L422-L425)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L418-L426


 - [ ] ID-226
[Panic.panic(uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol#L50-L56) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol#L51-L55)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol#L50-L56


 - [ ] ID-227
[GovernorUpgradeable._isValidDescriptionForProposer(address,string)](contracts/extensions/GovernorUpgradeable.sol#L792-L832) uses assembly
	- [INLINE ASM](contracts/extensions/GovernorUpgradeable.sol#L805-L813)

contracts/extensions/GovernorUpgradeable.sol#L792-L832


 - [ ] ID-228
[MessageHashUtils.toEthSignedMessageHash(bytes32)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#L30-L36) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#L31-L35)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#L30-L36


 - [ ] ID-229
[MessageHashUtils.toTypedDataHash(bytes32,bytes32)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#L75-L83) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#L76-L82)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#L75-L83


## boolean-equal
Impact: Informational
Confidence: High
 - [ ] ID-230
[GovernorBravoDelegate.castVoteInternal(address,uint256,uint8)](contracts/GovernorBravoDelegate.sol#L461-L482) compares to a boolean constant:
	-[require(bool,string)(receipt.hasVoted == false,GovernorBravo::castVoteInternal: voter already voted)](contracts/GovernorBravoDelegate.sol#L466)

contracts/GovernorBravoDelegate.sol#L461-L482


## constable-states
Impact: Optimization
Confidence: High
 - [ ] ID-231
[GovernorBravoDelegatorStorage.implementation](contracts/GovernorBravoInterfaces.sol#L67) should be constant 

contracts/GovernorBravoInterfaces.sol#L67


 - [ ] ID-232
[GovernorBravoDelegatorStorage.pendingAdmin](contracts/GovernorBravoInterfaces.sol#L64) should be constant 

contracts/GovernorBravoInterfaces.sol#L64


## incorrect-equality
Impact: Medium
Confidence: High
 - [ ] ID-233
[Comp._writeCheckpoint(address,uint32,uint96,uint96)](contracts/Comp.sol#L262-L273) uses a dangerous strict equality:
	- [nCheckpoints > 0 && checkpoints[delegatee][nCheckpoints - 1].fromBlock == blockNumber](contracts/Comp.sol#L265)

contracts/Comp.sol#L262-L273


## too-many-digits
Impact: Informational
Confidence: Medium
 - [ ] ID-234
[Comp.slitherConstructorConstantVariables()](contracts/Comp.sol#L4-L301) uses literals with too many digits:
	- [totalSupply = 10000000e18](contracts/Comp.sol#L15)

contracts/Comp.sol#L4-L301


## controlled-delegatecall
Impact: High
Confidence: Medium
 - [ ] ID-235
[GovernorBravoDelegator.delegateTo(address,bytes)](contracts/GovernorBravoDelegator.sol#L65-L72) uses delegatecall to a input-controlled function id
	- [(success,returnData) = callee.delegatecall(data)](contracts/GovernorBravoDelegator.sol#L66)

contracts/GovernorBravoDelegator.sol#L65-L72


 - [ ] ID-236
[GovernorBravoDelegator.fallback()](contracts/GovernorBravoDelegator.sol#L79-L95) uses delegatecall to a input-controlled function id
	- [(success,None) = implementation.delegatecall(msg.data)](contracts/GovernorBravoDelegator.sol#L81)

contracts/GovernorBravoDelegator.sol#L79-L95


## immutable-states
Impact: Optimization
Confidence: High
 - [ ] ID-237
[GovernorBravoDelegatorStorage.admin](contracts/GovernorBravoInterfaces.sol#L61) should be immutable 

contracts/GovernorBravoInterfaces.sol#L61


## arbitrary-send-eth
Impact: High
Confidence: Medium
 - [ ] ID-238
[GovernorUpgradeable.relay(address,uint256,bytes)](contracts/extensions/GovernorUpgradeable.sol#L693-L696) sends eth to arbitrary user
	Dangerous calls:
	- [(success,returndata) = target.call{value: value}(data)](contracts/extensions/GovernorUpgradeable.sol#L694)

contracts/extensions/GovernorUpgradeable.sol#L693-L696


 - [ ] ID-239
[GovernorUpgradeable._executeOperations(uint256,address[],uint256[],bytes[],bytes32)](contracts/extensions/GovernorUpgradeable.sol#L471-L482) sends eth to arbitrary user
	Dangerous calls:
	- [(success,returndata) = targets[i].call{value: values[i]}(calldatas[i])](contracts/extensions/GovernorUpgradeable.sol#L479)

contracts/extensions/GovernorUpgradeable.sol#L471-L482


## incorrect-exp
Impact: High
Confidence: Medium
 - [ ] ID-240
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) has bitwise-xor operator ^ instead of the exponentiation operator **: 
	 - [inverse = (3 * denominator) ^ 2](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L205)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-241
[Math.invMod(uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L243-L289) performs a multiplication on the result of a division:
	- [quotient = gcd / remainder](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L265)
	- [(gcd,remainder) = (remainder,gcd - remainder * quotient)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L267-L274)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L243-L289


 - [ ] ID-242
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L190)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L212)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


 - [ ] ID-243
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L190)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L214)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


 - [ ] ID-244
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L190)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L209)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


 - [ ] ID-245
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L190)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L210)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


 - [ ] ID-246
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L190)
	- [inverse = (3 * denominator) ^ 2](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L205)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


 - [ ] ID-247
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L190)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L211)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


 - [ ] ID-248
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L190)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L213)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


 - [ ] ID-249
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223) performs a multiplication on the result of a division:
	- [prod0 = prod0 / twos](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L193)
	- [result = prod0 * inverse](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L220)

lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L144-L223


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-250
4 different versions of Solidity are used:
	- Version constraint 0.8.26 is used by:
		-[0.8.26](contracts/CompoundGovernor.sol#L2)
		-[0.8.26](contracts/extensions/GovernorSettableFixedQuorumUpgradeable.sol#L2)
		-[0.8.26](contracts/extensions/GovernorVotesCompUpgradeable.sol#L2)
	- Version constraint ^0.8.10 is used by:
		-[^0.8.10](contracts/GovernorBravoInterfaces.sol#L2)
	- Version constraint ^0.8.20 is used by:
		-[^0.8.20](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L5)
		-[^0.8.20](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L5)
		-[^0.8.20](contracts/extensions/GovernorPreventLateQuorumUpgradeable.sol#L5)
		-[^0.8.20](contracts/extensions/GovernorSequentialProposalIdUpgradeable.sol#L3)
		-[^0.8.20](contracts/extensions/GovernorSettingsUpgradeable.sol#L5)
		-[^0.8.20](contracts/extensions/GovernorTimelockCompoundUpgradeable.sol#L5)
		-[^0.8.20](contracts/extensions/GovernorUpgradeable.sol#L5)
		-[^0.8.20](contracts/extensions/IGovernor.sol#L5)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L3)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC1271.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC165.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC6372.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC1155/IERC1155Receiver.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Address.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Errors.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Panic.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/Strings.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/cryptography/SignatureChecker.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#L5)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/Checkpoints.sol#L5)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/DoubleEndedQueue.sol#L3)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol#L5)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/utils/types/Time.sol#L4)
		-[^0.8.20](lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/vendor/compound/ICompoundTimelock.sol#L4)
	- Version constraint ^0.8.26 is used by:
		-[^0.8.26](contracts/interfaces/IComp.sol#L2)

contracts/CompoundGovernor.sol#L2


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-251
[ContextUpgradeable._contextSuffixLength()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L31-L33) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L31-L33


 - [ ] ID-252
[GovernorCountingFractionalUpgradeable.__GovernorCountingFractional_init_unchained()](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L73-L74) is never used and should be removed

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L73-L74


 - [ ] ID-253
[EIP712Upgradeable.__EIP712_init(string,string)](lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L68-L70) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol#L68-L70


 - [ ] ID-254
[ContextUpgradeable.__Context_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L21-L22) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L21-L22


 - [ ] ID-255
[ERC165Upgradeable.__ERC165_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L25-L26) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L25-L26


 - [ ] ID-256
[NoncesUpgradeable.__Nonces_init_unchained()](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L32-L33) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L32-L33


 - [ ] ID-257
[GovernorCountingSimpleUpgradeable.__GovernorCountingSimple_init_unchained()](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L47-L48) is never used and should be removed

contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L47-L48


 - [ ] ID-258
[GovernorCountingSimpleUpgradeable.__GovernorCountingSimple_init()](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L44-L45) is never used and should be removed

contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L44-L45


 - [ ] ID-259
[GovernorCountingFractionalUpgradeable._quorumReached(uint256)](contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L113-L117) is never used and should be removed

contracts/extensions/GovernorCountingFractionalUpgradeable.sol#L113-L117


 - [ ] ID-260
[ERC165Upgradeable.__ERC165_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L22-L23) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/introspection/ERC165Upgradeable.sol#L22-L23


 - [ ] ID-261
[NoncesUpgradeable.__Nonces_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L29-L30) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L29-L30


 - [ ] ID-262
[Initializable._getInitializedVersion()](lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L208-L210) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol#L208-L210


 - [ ] ID-263
[NoncesUpgradeable._useCheckedNonce(address,uint256)](lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L60-L65) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/NoncesUpgradeable.sol#L60-L65


 - [ ] ID-264
[ContextUpgradeable.__Context_init()](lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L18-L19) is never used and should be removed

lib/openzeppelin-contracts-upgradeable/contracts/utils/ContextUpgradeable.sol#L18-L19


## unimplemented-functions
Impact: Informational
Confidence: High
 - [ ] ID-265
[GovernorCountingSimpleUpgradeable](contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L13-L126) does not implement functions:
	- [GovernorUpgradeable.CLOCK_MODE()](contracts/extensions/GovernorUpgradeable.sol#L869)
	- [GovernorUpgradeable._getVotes(address,uint256,bytes)](contracts/extensions/GovernorUpgradeable.sol#L276)
	- [GovernorUpgradeable.clock()](contracts/extensions/GovernorUpgradeable.sol#L863)
	- [GovernorUpgradeable.quorum(uint256)](contracts/extensions/GovernorUpgradeable.sol#L884)
	- [GovernorUpgradeable.votingDelay()](contracts/extensions/GovernorUpgradeable.sol#L874)
	- [GovernorUpgradeable.votingPeriod()](contracts/extensions/GovernorUpgradeable.sol#L879)

contracts/extensions/GovernorCountingSimpleUpgradeable.sol#L13-L126


