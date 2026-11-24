# Blockchain Crowdfunding Smart Contract

**Unit:** CSE3BCC - Blockchain and Cryptocurrencies
**Student:** Khwaja Nazamuddin Najmi (22298201)

## About

A decentralised crowdfunding platform built as an Ethereum smart contract in Solidity. Contributors send ETH to a campaign, and the contract enforces the rules automatically, with no central intermediary.

## Features

| Feature | Function | Purpose |
|---|---|---|
| Contribute | `contribute()` | Lets users send ETH to the campaign |
| Withdraw | `withdrawFunds()` | Lets the owner withdraw funds once the goal is reached |
| Refund | `claimRefund()` | Returns ETH to contributors if the campaign fails |
| Check status | `getCampaignStatus()` | Shows the current campaign status |

## Events

- `ContributionReceived`
- `FundsWithdrawn`
- `RefundIssued`

## Error handling

The contract uses `require()` statements to block zero-value contributions, unauthorised withdrawals, withdrawals before the goal is reached, duplicate withdrawals, and invalid refund requests.

## Tech stack

Solidity, Hardhat 3, TypeScript, Alchemy, MetaMask, Ethereum Sepolia testnet

## Project structure

- `contracts/` - Crowdfunding.sol
- `scripts/` - deploy.js
- `hardhat.config.ts` - network and compiler configuration

## How to run

1. Install dependencies:
