import 'package:flutter/material.dart';
import 'package:flutter_web3/ethereum.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 5;
  String currentAddress = '';
  int currentChain = -1;
  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        currentAddress = accs.first;
      }
      currentChain = await ethereum!.getChainId();
      notifyListeners();
    }
  }

  Future<void> checkForConnection() async {
    bool accountsConnected = (await ethereum!.getAccounts()).isNotEmpty;
    if (ethereum!.isConnected() && accountsConnected) {
      connect();
    }
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    notifyListeners();
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
    }
    ethereum!.onChainChanged((chainId) {
      clear();
    });
  }
}
