// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {
    LegacyToken,
    Forta,
    CryptoVault,
    DoubleEntryPoint,
    DelegateERC20,
    IDetectionBot,
    IERC20
} from "ethernaut/levels/DoubleEntryPoint.sol";

contract DoubleEntryPointTest is Test {
    DoubleEntryPoint target;
    address player;

    function setUp() public {
        player = makeAddr("player");
        vm.deal(player, 10 ether);

        LegacyToken oldToken = new LegacyToken();
        Forta forta = new Forta();
        CryptoVault vault = new CryptoVault(player);

        // create token & set it as underlying token
        target = new DoubleEntryPoint(address(oldToken), address(vault), address(forta), player);
        vault.setUnderlying(address(target));

        // give legacy support
        oldToken.delegateToNewContract(DelegateERC20(address(target)));

        // mint some legacy tokens to the vault
        oldToken.mint(address(vault), 100 ether);
    }

    function attack() private {
        // register your detection bot to the target
        DetectionBot detectionBot = new DetectionBot(address(target.cryptoVault()));
        target.forta().setDetectionBot(address(detectionBot));
    }

    function testAttack() public {
        vm.startPrank(player);
        attack();
        vm.stopPrank();

        assertNotEq(
            address(target.forta().usersDetectionBots(player)), address(0), "user must have set a detection bot"
        );

        // (bool ok, bytes memory data) = trySweep(CryptoVault(target.cryptoVault()), target);
        // assertFalse(ok, "sweep should have failed");

        // bool prevented = abi.decode(data, (bool));
        // assertTrue(prevented, "bot should have detected it");
    }

    function trySweep(CryptoVault cryptoVault, DoubleEntryPoint instance) private returns (bool, bytes memory) {
        try cryptoVault.sweepToken(IERC20(instance.delegatedFrom())) {
            return (true, abi.encode(false));
        } catch {
            return (false, abi.encode(instance.balanceOf(instance.cryptoVault()) > 0));
        }
    }
}

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
