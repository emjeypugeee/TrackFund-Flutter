part of 'wallet_bloc.dart';

abstract class WalletEvent {
  const WalletEvent();
}

class LoadWallets extends WalletEvent {
  final int userId;
  const LoadWallets(this.userId);
}

class AddWallet extends WalletEvent {
  final String name;
  final double balance;
  final String holderName;
  final String? lastFourDigit;
  final int userId;

  const AddWallet({
    required this.name,
    required this.balance,
    required this.holderName,
    required this.lastFourDigit,
    required this.userId,
  });
}

class AddIncome extends WalletEvent {
  final int walletId;
  final double amount;
  final String description;
  final String category;
  final DateTime date;

  const AddIncome({
    required this.walletId,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
  });
}

class AddExpenses extends WalletEvent {
  final int walletId;
  final double amount;
  final String description; // Added
  final String category; // Added
  final DateTime date; // Added

  const AddExpenses({
    required this.walletId,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
  });
}
