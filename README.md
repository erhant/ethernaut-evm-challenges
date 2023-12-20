# Ethernaut & EVM Puzzles Solutions

Solutions to Ethernaut, EVM puzzles and More EVM Puzzles in [Foundry](https://book.getfoundry.sh/), migrated from my previous [solutions with Hardhat](https://github.com/erhant/solidity-ctfs).

## [Ethernaut](https://ethernaut.openzeppelin.com/)

We try to use the original Ethernaut levels whenever possible, but there are a few exceptions as noted below.

- [x] [Fallback](./docs/Ethernaut.md#1-fallback)
- [x] [Fallout](./docs/Ethernaut.md#2-fallout)<sup>\* uses v0.8 instead of v0.6</sup>
- [x] [CoinFlip](./docs/Ethernaut.md#3-coinflip)
- [x] [Telephone](./docs/Ethernaut.md#4-telephone)
- [x] [Token](./docs/Ethernaut.md#5-token)<sup>\* using v0.8 instead of v0.6</sup>
- [x] [Delegation](./docs/Ethernaut.md#6-delegation)
- [x] [Force](./docs/Ethernaut.md#7-force)
- [x] [Vault](./docs/Ethernaut.md#8-vault)
- [x] [King](./docs/Ethernaut.md#9-king)
- [x] [Reentrance](./docs/Ethernaut.md#10-reentrance)<sup>\* using v0.8 instead of v0.6</sup>
- [x] [Elevator](./docs/Ethernaut.md#11-elevator)
- [x] [Privacy](./docs/Ethernaut.md#12-privacy)
- [x] [Gatekeeper One](./docs/Ethernaut.md#13-gatekeeper-one)
- [x] [Gatekeeper Two](./docs/Ethernaut.md#14-gatekeeper-two)
- [x] [Naught Coin](./docs/Ethernaut.md#15-naught-coin)
- [x] [Preservation](./docs/Ethernaut.md#16-preservation)
- [x] [Recovery](./docs/Ethernaut.md#17-recovery)
- [x] [Magic Number](./docs/Ethernaut.md#18-naught-coin)
- [x] [Alien Codex](./docs/Ethernaut.md#19-alien-codex)<sup>\* requires v0.5, so we deploy bytecode via <code>CREATE</code></sup>
- [x] [Denial](./docs/Ethernaut.md#20-denial)
- [x] [Shop](./docs/Ethernaut.md#21-shop)
- [x] [Dex](./docs/Ethernaut.md#22-dex)
- [x] [Dex Two](./docs/Ethernaut.md#23-dex-two)
- [x] [Puzzle Wallet](./docs/Ethernaut.md#24-puzzle-wallet)
- [x] [Motorbike](./docs/Ethernaut.md#25-motorbike)<sup>\* using v0.8 instead of v0.7 or below</sup>
- [x] [Double Entry Point](./docs/Ethernaut.md#26-double-entry-point)
- [x] [Good Samaritan](./docs/Ethernaut.md#27-good-samaritan)
- [x] [Gatekeeper Three](./docs/Ethernaut.md#28-gatekeeper-three)
- [x] [Switch](./docs/Ethernaut.md#29-switch)

> [!TIP]
>
> For my old write-ups using Hardhat, see [here](https://dev.to/erhant/series/18918).

### Setup

For setup, you should do:

```sh
# Ethernaut levels are imported from the original repo
forge install OpenZeppelin/ethernaut

# Some levels use openzeppelin-contracts-08 as below
forge install openzeppelin-contracts-08=OpenZeppelin/openzeppelin-contracts@v4.7.3
```

### Scripts

We have scripts that can solve the puzzle & check if they are solved or not. First, write your credentials within an `.env` file, as shown in the `.env.example`. Then, you can scripts such as:

```sh
# Check if the level is solved
source .env && forge script ./scripts/<Level>.s.sol:Check -f=$RPC_URL

# Solve level
source .env && forge script ./scripts/<Level>.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY
```

## [EVM Puzzles](https://github.com/fvictorio/evm-puzzles/)

- [x] [Puzzle 1](./docs/EvmPuzzles.md#puzzle-1)
- [x] [Puzzle 2](./docs/EvmPuzzles.md#puzzle-2)
- [x] [Puzzle 3](./docs/EvmPuzzles.md#puzzle-3)
- [x] [Puzzle 4](./docs/EvmPuzzles.md#puzzle-4)
- [x] [Puzzle 5](./docs/EvmPuzzles.md#puzzle-5)
- [x] [Puzzle 6](./docs/EvmPuzzles.md#puzzle-6)
- [x] [Puzzle 7](./docs/EvmPuzzles.md#puzzle-7)
- [x] [Puzzle 8](./docs/EvmPuzzles.md#puzzle-8)
- [x] [Puzzle 9](./docs/EvmPuzzles.md#puzzle-9)
- [x] [Puzzle 10](./docs/EvmPuzzles.md#puzzle-10)

> [!TIP]
>
> For my old write-ups see [here](https://dev.to/erhant/evm-puzzles-walkthrough-471a).

## [More EVM Puzzles](https://github.com/daltyboy11/more-evm-puzzles)

- [x] [Puzzle 1](./docs/MoreEvmPuzzles.md#puzzle-1)
- [x] [Puzzle 2](./docs/MoreEvmPuzzles.md#puzzle-2)
- [x] [Puzzle 3](./docs/MoreEvmPuzzles.md#puzzle-3)
- [x] [Puzzle 4](./docs/MoreEvmPuzzles.md#puzzle-4)
- [x] [Puzzle 5](./docs/MoreEvmPuzzles.md#puzzle-5)
- [x] [Puzzle 6](./docs/MoreEvmPuzzles.md#puzzle-6)
- [x] [Puzzle 7](./docs/MoreEvmPuzzles.md#puzzle-7)
- [x] [Puzzle 8](./docs/MoreEvmPuzzles.md#puzzle-8)
- [x] [Puzzle 9](./docs/MoreEvmPuzzles.md#puzzle-9)
- [x] [Puzzle 10](./docs/MoreEvmPuzzles.md#puzzle-10)

> [!TIP]
>
> For my old write-ups see [here](https://dev.to/erhant/more-evm-puzzles-walkthrough-4lil).
