# Ethernaut & EVM Puzzles Solutions

Solutions to Ethernaut, EVM puzzles and More EVM Puzzles in [Foundry](https://book.getfoundry.sh/), migrated & improved from my previous [solutions with Hardhat](https://github.com/erhant/solidity-ctfs).

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

We use the original Ethernaut levels whenever possible, but there are a few exceptions as noted below. We also provide scripts to automatically solve & submit each problem, see [scripts](#scripts) section below.

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
- [x] [Puzzle Wallet](./script/PuzzleWallet.s.sol)
- [x] [Motorbike](./script/Motorbike.s.sol)<sup>\* using v0.8 instead of v0.7 or below</sup>
- [x] [Double Entry Point](./script/DoubleEntryPoint.s.sol)
- [x] [Good Samaritan](./script/GoodSamaritan.s.sol)
- [x] [Gatekeeper Three](./script/GatekeeperThree.s.sol)
- [x] [Switch](./script/Switch.s.sol)

> [!TIP]
>
> For my old write-ups using Hardhat, see [here](https://dev.to/erhant/series/18918).

### Scripts

We have a script for each Ethernaut level that can check if it is solved, or actually solve & submit it given an instance.

> [!IMPORTANT]
>
> We do not encourage running these scripts without even looking at the questions & trying them yourself. We only want these to be used so that you don't write everything from the console from scratch in the website!
>
> So please, try & solve the questions yourself before running these scripts!

#### Running a Script

First, write your credentials within an `.env` file, as shown in the `.env.example`. Then, on the Ethernaut website for some challenge, get a new instance and keep note of the level & instance address.

You can run scripts as shown below, with `<Level>` corresponding to the level name as it appears in the file name. These scripts will run the attack on actual contracts on the blockchain.

```sh
# Check if the instance is solved
source .env && forge script ./scripts/<Level>.s.sol:Check -f=$RPC_URL

# Solve & submit instance
source .env && forge script ./scripts/<Level>.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY
```

> [!TIP]
>
> To actually do the transactions on-chain, just add `--broadcast` flag to the command.
>
> If things go right, you should see a tick-mark on Ethernaut website with the same wallet, meaning that your submitted solution was accepted!

#### Edge Case: CoinFlip

In the CoinFlip level, we must deploy an attacker contract first and then call `flip()` on it on 10 different blocks. Foundry does not support this kind of behavior in a single script, as discussed in [this issue](https://github.com/foundry-rs/foundry/issues/1902).

For this reason, we must run the scripts for this level as follows:

```sh
# (1) deploy attacker
source .env && forge script ./scripts/Coinflip.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY -s="deploy()" --broadcast

# (2) save attacker address to .env as:
ATKR_COINFLIP=<attacker-address-here>

# (3) attack (do this 10 times)
source .env && forge script ./scripts/Coinflip.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY -s="flip()" --broadcast

# (4) run the script as usual to submit the instance
source .env && forge script ./scripts/Coinflip.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY --broadcast
```

#### Edge Case: Motorbike

In the Motorbike level, we use `selfdestruct` and the instance verification checks for the contract size of the self-destructed contract to see if it is 0. Due to how `selfdestruct` works, the contract size is only made 0 after the block is mined for that transaction, so in a single Foundry script we will not be able to see that effect, as per the [issue here](https://github.com/foundry-rs/foundry/issues/1902).

For this reason, the attack is in two steps:

```sh
# (1) deploy attacker
source .env && forge script ./scripts/Motorbike.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY -s="pwn()" --broadcast

# (2) run the script as usual to submit the instance
source .env && forge script ./scripts/Motorbike.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY --broadcast
```

#### Writing a Script

Here is what a script looks like for some challenge called `LevelName`:

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {CheckScript} from "./common/Check.sol";
import {SolveScript} from "./common/Solve.sol";
import {LevelName} from "ethernaut/levels/LevelName.sol";

contract Check is CheckScript("LEVEL_NAME") {}

contract Solve is SolveScript("LEVEL_NAME") {
    LevelName target;

    constructor() {
        target = LevelName(instance);
    }

    function attack() public override {
        // the attack code within the test can be copy-pasted here!
    }
}
```

Here, you just have to write the attack within `attack` function, and it should "just work". The `SolveScript` also exposes a variable called `player` that holds your address as well.

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
