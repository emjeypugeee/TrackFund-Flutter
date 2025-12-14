import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/data/repositories/wallet_repositories.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _repository;

  WalletBloc(this._repository) : super(WalletInitial()) {
    on<LoadWallets>((event, emit) async {
      // Inside on<LoadWallets>
      await emit.forEach(
        _repository.getWallets(event.userId),
        // No need to calculate total here anymore!
        onData: (List<UserWallet> data) => WalletLoaded(data),
        onError: (error, stackTrace) => WalletError(error.toString()),
      );
    });

    // Handler: Add Wallet
    on<AddWallet>((event, emit) async {
      try {
        await _repository.addWallet(
          event.name,
          event.balance,
          event.lastFourDigit,
          event.holderName,
          event.userId,
        );
      } catch (e) {
        emit(WalletError("Failed to add wallet: $e"));
      }
    });

    // Handler: Delete Wallet
    on<DeleteWallet>((event, emit) async {
      try {
        // You need to ensure deleteWallet exists in your Repository
        await _repository.deleteWallet(event.id);
      } catch (e) {
        emit(WalletError("Failed to delete wallet: $e"));
      }
    });

    // Handler: Update Wallet
    on<UpdateWallet>((event, emit) async {
      try {
        // You need to ensure updateWallet exists in your Repository
        await _repository.updateWallet(event.wallet);
      } catch (e) {
        emit(WalletError("Failed to update wallet: $e"));
      }
    });
    
    // Handler: Add Income
    on<AddIncome>((event, emit) async {
      try {
        await _repository.addIncome(
          event.walletId,
          event.amount,
          event.description,
          event.category,
          event.date,
        );
      } catch (e) {
        emit(WalletError("Failed to add income: $e"));
      }
    });

    // Handler: Add Expenses
    on<AddExpenses>((event, emit) async {
      try {
        await _repository.addExpense(
          event.walletId,
          event.amount,
          event.description,
          event.category,
          event.date,
        );
      } catch (e) {
        emit(WalletError("Failed to add expense: $e"));
      }
    });
  }
}
