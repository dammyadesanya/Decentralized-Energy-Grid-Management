# Decentralized Energy Grid Management System

A blockchain-based system for managing decentralized energy grids using Clarity smart contracts on the Stacks blockchain.

## Overview

This project implements a set of smart contracts that enable peer-to-peer energy trading and grid management in a decentralized manner. The system allows energy producers to register, report production, and receive payments, while consumers can register, receive energy allocations, and make payments.

## Smart Contracts

The system consists of five core contracts:

1. **Producer Verification Contract** (`producer-verification.clar`)
    - Validates energy generators
    - Maintains a registry of verified producers
    - Controls producer verification status

2. **Consumer Identity Contract** (`consumer-identity.clar`)
    - Manages energy user profiles
    - Tracks consumer registration and status
    - Controls consumer activation status

3. **Production Tracking Contract** (`production-tracking.clar`)
    - Records energy generation amounts
    - Verifies production claims
    - Maintains production history

4. **Distribution Contract** (`distribution.clar`)
    - Manages allocation of energy to consumers
    - Tracks energy distribution
    - Links producers and consumers

5. **Payment Settlement Contract** (`payment-settlement.clar`)
    - Handles automated billing and payments
    - Manages energy pricing
    - Tracks payment history

## Contract Interactions

The contracts interact with each other to form a complete energy management system:

- Producers register in the Producer Verification Contract
- Consumers register in the Consumer Identity Contract
- Producers report energy generation in the Production Tracking Contract
- The Distribution Contract allocates energy from producers to consumers
- The Payment Settlement Contract handles payments from consumers to producers

## Usage

### For Producers

1. Register as a producer using `register-producer`
2. Wait for admin verification
3. Report energy production using `report-production`
4. Receive payments automatically

### For Consumers

1. Register as a consumer using `register-consumer`
2. Receive energy allocations
3. Make payments using `make-payment`

### For Administrators

1. Verify producers using `verify-producer`
2. Verify production reports using `verify-production`
3. Allocate energy using `allocate-energy`
4. Set energy prices using `set-energy-price`

## Testing

Tests are implemented using Vitest. Run the tests with:

```bash
npm test
