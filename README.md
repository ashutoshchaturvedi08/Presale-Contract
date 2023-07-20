# Presale-Contract

The provided Solidity smart contract is a PresaleContract designed to facilitate the presale of a custom ERC20 token in exchange for USDT (Tether) or USDC (USD Coin) tokens. Let's break down the contract and its functionality:

SPDX-License-Identifier: This is a comment indicating the license under which the contract's code is published. In this case, it is the MIT License.

pragma solidity ^0.8.19: This specifies the version of the Solidity compiler that should be used. The caret (^) symbol means any compatible version above 0.8.19 but less than 0.9.0.

interface IBEP20: This is an interface representing the functions that a BEP-20 (Binance Smart Chain's equivalent of ERC20) token should implement. It includes functions for transferring tokens, checking balances, and approving token allowances.

contract PresaleContract: This is the main contract that manages the presale process.

Variables

owner: Stores the address of the contract deployer, who is the owner of the contract.
usdtToken: Represents the contract instance of the BEP-20 USDT token.
usdcToken: Represents the contract instance of the BEP-20 USDC token.
token: Represents the contract instance of the custom ERC20 token to be sold in the presale.
tokenPrice: Stores the price of one unit of the custom ERC20 token in USDT or USDC.
paused: A boolean variable indicating whether the presale is currently paused or not.
totalTokensSold: Keeps track of the total number of custom ERC20 tokens sold during the presale.
decimals: The number of decimals used by the custom ERC20 token.
decimalfactor: A factor used to convert token amounts between different decimal systems.


Functions:

constructor: The contract constructor that is called when the contract is deployed. It sets the initial values of the contract's state variables and initializes the instances of the ERC20 tokens to be used in the presale.
onlyOwner: A modifier that restricts access to certain functions only to the contract owner (the deployer).
ourTokenBalance, USDTBalance, and USDCBalance: View functions that allow the owner to check the contract's current balance of the custom ERC20 token, USDT, and USDC tokens, respectively.
setTokenPrice: Function allowing the owner to update the price of the custom ERC20 token in USDT or USDC.
setPause: Function allowing the owner to pause or resume the presale.
setNewTokenAddress, setNewUsdtAddress, and setNewUsdcAddress: Functions allowing the owner to change the contract addresses of the custom ERC20 token, USDT, and USDC, respectively.
buyWithUSTD and buyWithUSDC: Functions for participants to buy the custom ERC20 token in exchange for USDT or USDC tokens. The tokens are transferred from the buyer to the contract, and the corresponding amount of custom ERC20 tokens is transferred to the buyer.
withdrawTokens, withdrawUSDT, and withdrawUSDC: Functions for the contract owner to withdraw the remaining custom ERC20 tokens, USDT, or USDC tokens from the contract.
Events:

TokensPurchased: An event emitted when a participant successfully purchases custom ERC20 tokens during the presale.
Overall, this contract allows the owner to set the token price, manage the presale's pause status, update the token addresses, and withdraw any remaining tokens or collected USDT/USDC after the presale is completed. Participants can buy the custom ERC20 token with either USDT or USDC, subject to available allowances and balances.


Key functions provided by the contract are:

View functions to check the contract's balance of the custom ERC20 token and the balances of USDT and USDC tokens held in the contract.

A function to set the token price, which can be adjusted by the owner as needed.

A "setPause" function allowing the owner to pause or resume the presale, giving flexibility to manage the process effectively.

Functions to update contract addresses for the custom ERC20 token, USDT, and USDC, enabling seamless integration with different tokens if needed.

Two main purchase functions, "buyWithUSTD" and "buyWithUSDC," where participants can buy the custom ERC20 token by providing USDT or USDC tokens in exchange. These functions validate the allowances and balances of the buyers and handle the token transfers accordingly. Events are emitted to track successful purchases.
