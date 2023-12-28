# Ethernaut & EVM Puzzles Solutions

Solutions to Ethernaut, EVM puzzles and More EVM Puzzles in [Foundry](https://book.getfoundry.sh/), migrated & improved from my previous [solutions with Hardhat](https://github.com/erhant/solidity-ctfs). All solutions can be found under the [test](./test/) folder, within the tests for each challenge.

To get started:

```sh
forge install
```

Then, see the solutions in action via:

```sh
forge test
```

> [!NOTE]
>
> We are making use of the following libraries for Ethernaut, shown via their installation commands:
>
> ```sh
> forge install OpenZeppelin/ethernaut
> forge install openzeppelin-contracts-08=OpenZeppelin/openzeppelin-contracts@v4.7.3
> ```

## [Ethernaut](https://ethernaut.openzeppelin.com/)

We try to use the original Ethernaut levels whenever possible, but there are a few exceptions as noted below. We also provide scripts to automatically solve & submit each problem, see [script](./script/) folder for details.

- [x] [Hello Ethernaut](./script/HelloEthernaut.s.sol)
- [x] [Fallback](./script/Fallback.s.sol)
- [x] [Fallout](./script/Fallout.s.sol)<sup>\* uses v0.8 instead of v0.6</sup>
- [x] [CoinFlip](./script/Coinflip.s.sol)
- [x] [Telephone](./script/Telephone.s.sol)
- [x] [Token](./script/Token.s.sol)<sup>\* using v0.8 instead of v0.6</sup>
- [x] [Delegation](./script/Delegation.s.sol)
- [x] [Force](./script/Force.s.sol)
- [x] [Vault](./script/Vault.s.sol)
- [x] [King](./script/King.s.sol)
- [x] [Reentrance](./script/Reentrance.s.sol)<sup>\* using v0.8 instead of v0.6</sup>
- [x] [Elevator](./script/Elevator.s.sol)
- [x] [Privacy](./script/Privacy.s.sol)
- [x] [Gatekeeper One](./script/GatekeeperOne.s.sol)
- [x] [Gatekeeper Two](./script/GatekeeperTwo.s.sol)
- [x] [Naught Coin](./script/NaughtCoin.s.sol)
- [x] [Preservation](./script/Preservation.s.sol)
- [x] [Recovery](./script/Recovery.s.sol)
- [x] [Magic Number](./script/MagicNum.s.sol)
- [x] [Alien Codex](./script/AlienCodex.s.sol)<sup>\* requires v0.5, so we deploy bytecode via <code>CREATE</code></sup>
- [x] [Denial](./script/Denial.s.sol)
- [x] [Shop](./script/Shop.s.sol)
- [x] [Dex](./script/Dex.s.sol)
- [x] [Dex Two](./script/DexTwo.s.sol)
- [x] [Puzzle Wallet](-)
- [x] [Motorbike](-)<sup>\* using v0.8 instead of v0.7 or below</sup>
- [x] [Double Entry Point](./script/DoubleEntryPoint.s.sol)
- [x] [Good Samaritan](./script/GoodSamaritan.s.sol)
- [x] [Gatekeeper Three](./script/GatekeeperThree.s.sol)
- [x] [Switch](./script/Switch.s.sol)

> [!TIP]
>
> For my old write-ups using Hardhat, see [here](https://dev.to/erhant/series/18918).

## [EVM Puzzles](https://github.com/fvictorio/evm-puzzles/)

- [x] [Puzzle 1](./test/evm/MoreEVMPuzzles.t.sol#L7)
- [x] [Puzzle 2](./test/evm/MoreEVMPuzzles.t.sol#L15)
- [x] [Puzzle 3](./test/evm/MoreEVMPuzzles.t.sol#L23)
- [x] [Puzzle 4](./test/evm/MoreEVMPuzzles.t.sol#L31)
- [x] [Puzzle 5](./test/evm/MoreEVMPuzzles.t.sol#L39)
- [x] [Puzzle 6](./test/evm/MoreEVMPuzzles.t.sol#L47)
- [x] [Puzzle 7](./test/evm/MoreEVMPuzzles.t.sol#L53)
- [x] [Puzzle 8](./test/evm/MoreEVMPuzzles.t.sol#L57)
- [x] [Puzzle 9](./test/evm/MoreEVMPuzzles.t.sol#L65)
- [x] [Puzzle 10](./test/evm/MoreEVMPuzzles.t.sol#L69)

> [!TIP]
>
> For my write-ups see [here](https://dev.to/erhant/evm-puzzles-walkthrough-471a).

## [More EVM Puzzles](https://github.com/daltyboy11/more-evm-puzzles)

- [x] [Puzzle 1](./test/evm/EVMPuzzles.t.sol#L7)
- [x] [Puzzle 2](./test/evm/EVMPuzzles.t.sol#L11)
- [x] [Puzzle 3](./test/evm/EVMPuzzles.t.sol#L15)
- [x] [Puzzle 4](./test/evm/EVMPuzzles.t.sol#L20)
- [x] [Puzzle 5](./test/evm/EVMPuzzles.t.sol#L24)
- [x] [Puzzle 6](./test/evm/EVMPuzzles.t.sol#L28)
- [x] [Puzzle 7](./test/evm/EVMPuzzles.t.sol#L33)
- [x] [Puzzle 8](./test/evm/EVMPuzzles.t.sol#L37)
- [x] [Puzzle 9](./test/evm/EVMPuzzles.t.sol#L43)
- [x] [Puzzle 10](./test/evm/EVMPuzzles.t.sol#L47)

> [!TIP]
>
> For my write-ups see [here](https://dev.to/erhant/more-evm-puzzles-walkthrough-4lil).
