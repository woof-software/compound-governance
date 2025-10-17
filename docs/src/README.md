[![ci](https://github.com/compound-finance/compound-governance/actions/workflows/test.yaml/badge.svg)](https://github.com/compound-finance/compound-governance/actions/workflows/test.yaml)
[![Coverage Status](https://coveralls.io/repos/github/compound-finance/compound-governance/badge.svg?t=thm1Vz)](https://coveralls.io/github/compound-finance/compound-governance)

# Compound Governance

This repository hosts the up-to-date contracts for the Compound Protocol governance system. It includes both the legacy Governor Bravo implementation and the new Compound Governor implementation, providing a comprehensive governance solution for the Compound DAO.

## Table of Contents

- [Overview](#overview)
- [Setup](#setup)
- [Environment Configuration](#environment-configuration)
- [Contract Compilation](#contract-compilation)
- [Running Tests](#running-tests)
- [Code Analysis](#code-analysis)
  - [Slither Analysis](#slither-analysis)
  - [Aderyn Analysis](#aderyn-analysis)
- [Project Structure](#project-structure)
- [Changelog](#changelog)

## Overview

The Compound Governance system consists of two main governance implementations:

1. **Governor Bravo** - The legacy governance system currently in use by Compound
2. **Compound Governor** - A new, upgradeable governance system built on OpenZeppelin's Governor framework

The new Compound Governor includes advanced features such as:

- Fractional voting
- Sequential proposal IDs
- Fixed quorum settings
- Late quorum prevention
- Whitelist management
- Integration with Compound's timelock system

## Setup

### Prerequisites

- Node.js >= 10.4.0
- npm or yarn package manager
- Git

### Installation

1. Clone the repository:

```bash
git clone https://github.com/compound-finance/compound-governance.git
cd compound-governance
```

2. Install dependencies:

```bash
npm install && git submodule update --init --recursive
```

## Environment Configuration

1. Copy the example environment file:

```bash
cp example.env .env
```

2. Configure your environment variables in `.env`:

```bash
RPC_URL=your_rpc_url_here
ETHERSCAN_API_KEY=your_etherscan_api_key
DEPLOYER_ADDRESS=your_deployer_address
DEPLOYER_PRIVATE_KEY=your_deployer_private_key
```

## Contract Compilation

This project supports both Hardhat and Foundry for compilation and testing:

### Using Hardhat

```bash
# Compile contracts
npm run buildh
```

### Using Foundry

```bash
# Compile contracts
npm run buildf
```

### Clean Build Artifacts

```bash
# Clean all build artifacts
npm run clean
```

## Running Tests

The project includes comprehensive test suites for both Hardhat and Foundry:

### Hardhat Tests

```bash
# Run all Hardhat tests
npm run testh

# Run Hardhat tests with coverage
npm run coverageh
```

### Foundry Tests

```bash
# Run all Foundry tests
npm run testf

# Run Foundry tests with coverage
npm run coveragef
```

### Test Structure

- **Hardhat Tests** (`test/*.ts`): Integration tests and TypeScript-based testing
- **Foundry Tests** (`test/*.t.sol`): Solidity-based unit and integration tests

## Code Analysis

### Slither Analysis

[Slither](https://github.com/crytic/slither) is a static analysis framework for Solidity that detects vulnerabilities and code quality issues.

```bash
# Run Slither analysis
npm run slither
```

The analysis results will be saved to `SLITHER_REPORT.md`.

### Aderyn Analysis

[Aderyn](https://github.com/Cyfrin/aderyn) is a modern static analyzer for Solidity smart contracts.

```bash
# Run Aderyn analysis
npm run aderyn
```

The analysis results will be saved to `ADERYN_REPORT.md`.

## Project Structure

```
contracts/
├── CompoundGovernor.sol          # Main upgradeable governance contract
├── GovernorBravoDelegate.sol     # Legacy Governor Bravo implementation
├── GovernorBravoDelegator.sol    # Governor Bravo proxy contract
├── GovernorBravoInterfaces.sol   # Governor Bravo interfaces
├── Comp.sol                      # COMP token contract
├── Timelock.sol                  # Timelock contract
├── SafeMath.sol                  # Safe math utilities
├── extensions/                   # OpenZeppelin Governor extensions
├── interfaces/                   # Contract interfaces
└── test/                        # Test contracts

test/
├── *.t.sol                      # Foundry test files
├── *.ts                         # Hardhat test files
└── helpers/                     # Test helper contracts

script/
├── DeployCompoundGovernor.s.sol # Deployment scripts
└── ProposeUpgrade*.s.sol        # Upgrade proposal scripts
```

## Changelog

For detailed information about contract versions, features, and changes between versions, see the [CHANGELOG.md](CHANGELOG.md) file.

The project includes three main contract versions:

- **V1**: `GovernorBravoDelegate.sol` - Legacy governance system
- **V2**: `CompoundGovernorV2.sol` - Modern upgradeable governance with OpenZeppelin framework
- **V2.1**: `CompoundGovernor.sol` - Enhanced version with allowed proposers system

## License

This project is licensed under the BSD-3-Clause License - see the [LICENSE](LICENSE) file for details.
