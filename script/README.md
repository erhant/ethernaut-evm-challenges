# Scripts

We have a script for each Ethernaut level that can check if it is solved, or actually solve & submit it given an instance.

> [!IMPORTANT]
>
> We do not encourage running these scripts without even looking at the questions & trying them yourself. We only want these to be used so that you don't write everything from the console from scratch in the website!
>
> So please, try & solve the questions yourself before running these scripts!

## Running a Script

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

### Edge Cases

In the CoinFlip level, we must deploy an attacker contract first and then call `flip()` on it on 10 different blocks. For this reason, we must run the scripts as follows:

```sh
# (1) deploy attacker
source .env && forge script ./scripts/Coinflip.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY -s="deploy()" --broadcast

# (2) save attacker address to .env as:
ATKR_COINFLIP=0x1234 # attacker address

# (3) attack (do this 10 times)
source .env && forge script ./scripts/Coinflip.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY -s="flip()" --broadcast

# (4) run the script as usual to submit the instance
source .env && forge script ./scripts/Coinflip.s.sol:Solve -f=$RPC_URL --private-key=$PRIVATE_KEY --broadcast
```

## Writing a Script

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
