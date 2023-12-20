// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IDetectionBot, Forta} from "ethernaut/levels/DoubleEntryPoint.sol";

contract DetectionBot is IDetectionBot {
    address public cryptoVaultAddress;

    constructor(address _cryptoVaultAddress) {
        cryptoVaultAddress = _cryptoVaultAddress;
    }

    function handleTransaction(address user, bytes calldata /* msgData */ ) external override {
        // extract sender from calldata
        address origSender;
        assembly {
            origSender := calldataload(0xa8)
        }

        // raise alert only if the msg.sender is CryptoVault contract
        if (origSender == cryptoVaultAddress) {
            Forta(msg.sender).raiseAlert(user);
        }
    }
}
