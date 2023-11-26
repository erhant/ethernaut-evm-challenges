# Ethernaut Solutions

Solutions to Ethernaut, EVM puzzles and More EVM Puzzles in [Foundry](https://book.getfoundry.sh/), migrated from my previous [solutions with Hardhat](https://github.com/erhant/solidity-ctfs).

- [**Ethernaut**](https://ethernaut.openzeppelin.com/) | [Writeups](https://dev.to/erhant/series/18918)
  - [(**1**)](./docs/ethernaut/Fallback.md) Fallback
  - [(**2**)](./docs/ethernaut/Fallout.md) Fallout
  - [(**3**)](./docs/ethernaut/Coinflip.md) CoinFlip
  - [(**4**)](./docs/ethernaut/Telephone.md) Telephone
  - [(**5**)](./docs/ethernaut/Token.md) Token
  - [(**6**)](./docs/ethernaut/Delegation.md) Delegation
  - [(**7**)](./docs/ethernaut/Force.md) Force
  - [(**8**)](./docs/ethernaut/Vault.md) Vault
  - [(**9**)](./docs/ethernaut/King.md) King
  - [(**10**)](./docs/ethernaut/Reentrancy.md) Reentrancy
  - [(**11**)](./docs/ethernaut/Elevator.md) Elevator
  - [(**12**)](./docs/ethernaut/Privacy.md) Privacy
  - [(**13**)](./docs/ethernaut/GatekeeperOne.md) Gatekeeper One
  - [(**14**)](./docs/ethernaut/GatekeeperTwo.md) Gatekeeper Two
  - [(**15**)](./docs/ethernaut/NaughtCoin.md) Naught Coin
  - [(**16**)](./docs/ethernaut/Preservation.md) Preservation
  - [(**17**)](./docs/ethernaut/Recovery.md) Recovery
  - [(**18**)](./docs/ethernaut/MagicNumber.md) Magic Number
  - [(**19**)](./docs/ethernaut/AlienCodex.md) Alien Codex
  - [(**20**)](./docs/ethernaut/Denial.md) Denial
  - [(**21**)](./docs/ethernaut/Shop.md) Shop
  - [(**22**)](./docs/ethernaut/DexOne.md) Dex One
  - [(**23**)](./docs/ethernaut/DexTwo.md) Dex Two
  - [(**24**)](./docs/ethernaut/PuzzleWallet.md) Puzzle Wallet
  - [(**25**)](./docs/ethernaut/Motorbike.md) Motorbike
  - [(**26**)](./docs/ethernaut/DoubleEntryPoint.md) Double Entry Point
  - [(**27**)](./docs/ethernaut/GoodSamaritan.md) Good Samaritan
  - [(**28**)](./docs/ethernaut/GatekeeperThree.md) Gatekeeper Three
  - [(**29**)](/): Switch (TODO)
- [**EVM Puzzles**](https://github.com/fvictorio/evm-puzzles/) | [Writeups](https://dev.to/erhant/evm-puzzles-walkthrough-471a)
  - [(**\***)](./docs/evmpuzzles/Puzzles.md) Puzzles
- [**More EVM Puzzles**](https://github.com/daltyboy11/more-evm-puzzles) | [Writeups](https://dev.to/erhant/more-evm-puzzles-walkthrough-4lil)
  - [(**\***)](./docs/moreevmpuzzles/MorePuzzles.md) More Puzzles

## Setup

You can solve these puzzles by yourself by creating a repo from scratch too. Do the following:

```sh
# create a folder
mkdir <your-project>
cd <your-project>

# initialize foundry
forge init

# install OpenZeppelin dependency
forge install git@github.com:OpenZeppelin/openzeppelin-contracts.git
```

The EVM puzzles are simple test files, I didn't bother creating contracts for each puzzle there. The real deal is with Ethernaut puzzles.
