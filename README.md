# Ethernaut & EVM Puzzles Solutions

Solutions to Ethernaut, EVM puzzles and More EVM Puzzles in [Foundry](https://book.getfoundry.sh/), migrated from my previous [solutions with Hardhat](https://github.com/erhant/solidity-ctfs).

## [Ethernaut](https://ethernaut.openzeppelin.com/)

For my old write-ups via Hardhat, see [here](https://dev.to/erhant/series/18918). We try to use the original Ethernaut levels whenever possible, but there are a few exceptions: those with a `*` in their name are not imported from Ethernaut. Instead, their slightly changed versions are used (you can find them under [src](./src/)) although the attack is still the same. The reason for doing this that either the attack is no longer valid with the newer versions, or there is a broken import or something.

- [x] [Fallback](./docs/Ethernaut.md#1-fallback)
- [x] [Fallout](./docs/Ethernaut.md#2-fallout)<sup>\*</sup>
- [x] [CoinFlip](./docs/Ethernaut.md#3-coinflip)
- [x] [Telephone](./docs/Ethernaut.md#4-telephone)
- [x] [Token](./docs/Ethernaut.md#5-token)<sup>\*</sup>
- [x] [Delegation](./docs/Ethernaut.md#6-delegation)
- [x] [Force](./docs/Ethernaut.md#7-force)
- [x] [Vault](./docs/Ethernaut.md#8-vault)
- [x] [King](./docs/Ethernaut.md#9-king)
- [x] [Reentrance](./docs/Ethernaut.md#10-reentrance)<sup>\*</sup>
- [x] [Elevator](./docs/Ethernaut.md#11-elevator)
- [x] [Privacy](./docs/Ethernaut.md#12-privacy)
- [x] [Gatekeeper One](./docs/Ethernaut.md#13-gatekeeper-one)
- [x] [Gatekeeper Two](./docs/Ethernaut.md#14-gatekeeper-two)
- [x] [Naught Coin](./docs/Ethernaut.md#15-naught-coin)
- [x] [Preservation](./docs/Ethernaut.md#16-preservation)
- [x] [Recovery](./docs/Ethernaut.md#17-recovery)
- [x] [Magic Number](./docs/Ethernaut.md#18-naught-coin)
- [x] [Alien Codex](./docs/Ethernaut.md#19-alien-codex)<sup>\*</sup>
- [x] Denial
- [x] Shop
- [x] Dex<sup>\*</sup>
- [x] Dex Two<sup>\*</sup>
- [ ] Puzzle Wallet<sup>\*</sup>
- [ ] Motorbike
- [ ] Double Entry Point
- [ ] Good Samaritan
- [ ] Gatekeeper Three
- [ ] Switch

### Solving Yourself

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

Each Ethernaut puzzle is set-up, solved, and verified within its respective test. For each challenge (assuming a `Challenge` contract under `src/Challenge.sol`) a test file will look like the following:

```sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Challenge} from "~/Challenge.sol";

contract ChallengeTest is Test {
    Challenge target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 1 ether);

        // TODO: setup
        Challenge delegate = new Challenge();
    }

    function attack() private {
        // TODO: attack
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        // TODO: verify
    }
}
```

## [EVM Puzzles](https://github.com/fvictorio/evm-puzzles/)

For my old write-ups see [here](https://dev.to/erhant/evm-puzzles-walkthrough-471a).

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

## [More EVM Puzzles](https://github.com/daltyboy11/more-evm-puzzles)

For my old write-ups see [here](https://dev.to/erhant/more-evm-puzzles-walkthrough-4lil).

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
