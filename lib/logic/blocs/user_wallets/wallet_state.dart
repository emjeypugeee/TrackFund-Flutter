part of 'wallet_bloc.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final List<UserWallet> wallets;
  WalletLoaded(this.wallets);

  double get totalBalance {
    if (wallets.isEmpty) return 0.0;
    return wallets.fold(0.0, (sum, wallet) => sum + wallet.walletBalance);
  }
}

class DeleteWallet extends WalletEvent {
  final int id;
  const DeleteWallet(this.id);
}

class UpdateWallet extends WalletEvent {
  final UserWallet wallet;
  const UpdateWallet(this.wallet);
}

class WalletError extends WalletState {
  final String message;
  WalletError(this.message);
}
