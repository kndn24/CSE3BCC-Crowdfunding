# Blockchain Crowdfunding Smart Contract

**Unit:** CSE3BCC - Blockchain and Cryptocurrencies


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
   npm install

2. Compile the contract:

npx hardhat compile

3. Set your environment variables (never commit real values):

SEPOLIA_RPC_URL=your_alchemy_sepolia_url
SEPOLIA_PRIVATE_KEY=your_wallet_private_key

4. Deploy to Sepolia:

npx hardhat run scripts/deploy.js --network sepolia


## Deployment

Deployed on the Ethereum Sepolia testnet with the campaign "Community Project", a goal of 0.01 ETH, and a 7-day duration. The source code is verified on Sepolia Etherscan.

## Future improvements

- Milestone-based fund release with contributor voting
- A web DApp front end
- Stablecoin support
- An independent security audit before real-world use
