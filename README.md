# INR Token Bridge - Codebase Documentation

## Overview

This project implements a cross-chain token bridge for INR tokens between Ethereum and Base networks. It allows users to transfer tokens between these chains through a bridging mechanism.

## Core Components

### Tokens

1. **INRToken** (`src/INRToken.sol`)
   - ERC20 token deployed on Ethereum
   - Features: minting (owner only) and burning functionality
   - Inherits from OpenZeppelin's ERC20 and Ownable contracts

2. **wINRToken** (`src/wINRToken.sol`)
   - Wrapped version of INRToken deployed on Base network
   - Features: minting (owner only) and burning functionality
   - Represents the bridged tokens on the destination chain

### Bridge Contracts

1. **BridgeETH** (`src/BridgeETH.sol`)
   - Deployed on Ethereum chain
   - Handles token deposits from users
   - Tracks pending balances that can be withdrawn
   - Owner can update balances when tokens are burned on the other side

2. **BridgeBase** (`src/BridgeBase.sol`)
   - Deployed on Base network
   - Mints wrapped tokens when deposits happen on Ethereum
   - Burns wrapped tokens when users want to bridge back to Ethereum
   - Uses IWINR interface to interact with the wrapped token

## Bridge Mechanism

1. **Ethereum → Base:**
   - User deposits INR tokens to BridgeETH
   - Off-chain relayer detects deposit event
   - Relayer calls BridgeBase.mint() to mint wINR tokens on Base

2. **Base → Ethereum:**
   - User burns wINR tokens via BridgeBase
   - Off-chain relayer detects burn event
   - Relayer calls BridgeETH.burnedOnOtherSide() to create withdrawal availability

## Testing

- `test/INTToken.t.sol`: Comprehensive test suite for the INR token functionality
  - Tests basic ERC20 functions (transfers, approvals)
  - Tests mint/burn functionality
  - Tests access control for restricted functions
  - Tests event emissions

## Deployment

- `script/Deploy.s.sol`: Foundry script to deploy the INR token contracts

## Project Structure

