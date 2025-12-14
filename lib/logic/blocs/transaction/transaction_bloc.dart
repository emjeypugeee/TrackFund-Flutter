import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/data/repositories/wallet_repositories.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_event.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final WalletRepository _repository;

  TransactionBloc(this._repository) : super(TransactionInitial()) {
    on<LoadTransactions>((event, emit) async {
      emit(TransactionLoading());

      await emit.forEach(
        _repository.getUserTransactions(event.userId),
        onData: (List<Transaction> data) {
          double income = 0;
          double expense = 0;

          for (var t in data) {
            if (t.type.toUpperCase() == 'INCOME') {
              income += t.amount;
            } else if (t.type.toUpperCase() == 'EXPENSE') {
              expense += t.amount;
            }
          }

          final chartData = _calculateWeeklyData(data);

          return TransactionLoaded(data, income, expense, chartData);
        },
        onError: (e, s) => TransactionError(e.toString()),
      );
    });

    on<DeleteTransaction>((event, emit) async {
      try {
        await _repository.deleteTransaction(event.id);
      } catch (e) {
        emit(TransactionError("Failed to delete transaction: $e"));
      }
    });
  }
}

List<Map<String, double>> _calculateWeeklyData(List<Transaction> transactions) {
  // Initialize 4 weeks with 0.0
  List<Map<String, double>> weeks = List.generate(4, (_) => {'income': 0.0, 'expense': 0.0});

  final now = DateTime.now();
  // Normalize "today" to midnight to fix the "Time of Day" bug
  final today = DateTime(now.year, now.month, now.day);

  for (var t in transactions) {
    final tDate = t.transactionDate;
    // Normalize transaction date to midnight
    final transactionDay = DateTime(tDate.year, tDate.month, tDate.day);

    final difference = today.difference(transactionDay).inDays;

    // Only look at the last 28 days
    if (difference < 28 && difference >= 0) {
      // Calculate which bucket (0-3) this belongs to
      int weekIndex = 3 - (difference ~/ 7);

      if (weekIndex >= 0 && weekIndex < 4) {
        if (t.type.toUpperCase() == 'INCOME') {
          weeks[weekIndex]['income'] = (weeks[weekIndex]['income'] ?? 0) + t.amount;
        } else {
          weeks[weekIndex]['expense'] = (weeks[weekIndex]['expense'] ?? 0) + t.amount;
        }
      }
    }
  }
  return weeks;
}
