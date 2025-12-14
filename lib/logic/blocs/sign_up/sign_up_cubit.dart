import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/data/models/temp_wallet.dart';
import 'package:track_fund/data/repositories/user_data_repositories.dart';
import 'package:track_fund/data/repositories/wallet_repositories.dart';

// --- STATE ---
class SignUpState {
  final List<TempWallet> tempWallets;
  final bool isSubmitting;

  // Helper to calculate total
  double get totalIncome => tempWallets.fold(0, (sum, item) => sum + item.balance);

  SignUpState({this.tempWallets = const [], this.isSubmitting = false});
}

// --- CUBIT ---
class SignUpCubit extends Cubit<SignUpState> {
  final WalletRepository _walletRepository;
  final UserDataRepositories _userRepository;

  SignUpCubit(this._walletRepository, this._userRepository) : super(SignUpState());

  // 1. Add to Memory (Updated to accept new fields)
  void addTempWallet({
    required String name,
    required double balance,
    required String holderName,
    required String lastFourDigit,
  }) {
    // Create the wallet with all 4 fields
    final newWallet = TempWallet(
      name: name,
      balance: balance,
      holderName: holderName,
      lastFourDigit: lastFourDigit,
    );

    // Update the list
    emit(SignUpState(tempWallets: [...state.tempWallets, newWallet]));
  }

  // 2. Remove from Memory
  void removeTempWallet(int index) {
    final newList = List<TempWallet>.from(state.tempWallets);
    newList.removeAt(index);
    emit(SignUpState(tempWallets: newList));
  }

  // 3. Finalize: Save EVERYTHING to DB
  Future<void> submitSignUp({
    required String username,
    required String password,
    required String email,
    required String contact,
  }) async {
    emit(SignUpState(tempWallets: state.tempWallets, isSubmitting: true));

    try {
      // 1. DEFINE 'newUser' HERE
      final newUser = UsersCompanion.insert(
        username: username,
        password: password,
        email: email,
        contact: contact,
      );

      final int newUserId = await _userRepository.createUserAndReturnId(newUser);

      for (var wallet in state.tempWallets) {
        await _walletRepository.addWallet(
          wallet.name,
          wallet.balance,
          wallet.lastFourDigit,
          wallet.holderName,
          newUserId,
        );
      }

      emit(SignUpState(tempWallets: [], isSubmitting: false));
    } catch (e) {
      print("Error during sign up: $e");
      emit(SignUpState(tempWallets: state.tempWallets, isSubmitting: false));
      rethrow;
    }
  }
}
