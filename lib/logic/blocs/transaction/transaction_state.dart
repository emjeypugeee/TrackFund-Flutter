import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_event.dart';

abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  // Note: Make sure 'Transaction' (singular) matches your Drift table class name
  // If your table is named 'Transactions', the row class Drift generates is usually 'Transaction'
  final List<Transaction> transactions;
  final double totalIncome;
  final double totalExpense;
  final List<Map<String, double>> weeklyChartData;

  const TransactionLoaded(
    this.transactions,
    this.totalIncome,
    this.totalExpense,
    this.weeklyChartData,
  );
}

class DeleteTransaction extends TransactionEvent {
  final int id;
  const DeleteTransaction(this.id);
}

class TransactionError extends TransactionState {
  final String message;
  const TransactionError(this.message);
}
