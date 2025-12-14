abstract class TransactionEvent {
  const TransactionEvent();
}
class LoadTransactions extends TransactionEvent {
    final int userId;
    LoadTransactions(this.userId);
  }
