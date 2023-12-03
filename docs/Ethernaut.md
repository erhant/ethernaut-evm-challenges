# Ethernaut

[Ethernaut](https://ethernaut.openzeppelin.com) is a Web3/Solidity based wargame inspired by [overthewire.org](https://overthewire.org/wargames/), played in the Ethereum Virtual Machine. Each level is a smart contract that needs to be 'hacked'. The game is 100% open source and all levels are contributions made by other players.

## 1. Fallback

The `receive` function allows one to become an owner as long as there is a contribution. Just make a contribution and then call `receive` by sending 1 wei.

## 2. Fallout

The supposed constructor is named `Fal1out` instead of `Fallout`, which is the exploit.

## 3. CoinFlip

The "random" coinflip is not actually random, the guess can be crafted within the same transaction. We just write a contract that finds the correct coinflip guess, and calls `flip` with that for 10 blocks.

## 4. Telephone

We just need an intermediary contract so that `msg.sender` is different from `tx.origin`.

## 5. Token

There is an integer underflow exploit within the `transfer` function. This affects both the `require` statement, as well as the transfer logic itself. Simply transferring an amount larger than the player balance to any address will suffice.

## 6. Delegation

This is a classic "storage-collision" bug that is usually characteristic to `delegatecall`. Thankfully, the author told us which function to call by naming it `pwn`.

## 7. Force

`selfdestruct` will "forcefully" transfer the destroyed contract's balance to a given target, that is the trick!

## 8. Vault

Having a state variable `private` does not mean you can't read it from the storage. Just read the correct slot and unlock the vault.

## 9. King

When a king is updated, the existing funds are transferred back to the previous king. We can break this by disallowing money transfers with a contract, and make that contract the king.

## 10. Reentrance

The classic bug that still haunts the Web3 scene! We re-enter the function from within the `receive` of an attacker contract.

## 11. Elevator

`isLastFloor` is a pretty relaxed function, we can return whatever we want whenever we want.
