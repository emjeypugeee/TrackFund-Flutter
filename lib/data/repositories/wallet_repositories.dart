import 'package:drift/drift.dart';
import '../local/database/app_database.dart';

class WalletRepository {
  final AppDatabase _db;

  WalletRepository(this._db);

  // 1. Get all wallets (Stream allows real-time updates)
  Stream<List<UserWallet>> getWallets(int userId) {
    // Select * from user_wallets WHERE user_id = userId
    return (_db.select(_db.userWallets)..where((tbl) => tbl.userId.equals(userId))).watch();
  }

  // Load All transactions
  Stream<List<Transaction>> getUserTransactions(int userId) {
    // 1. Join Transactions with Wallets to filter by User ID
    final query = _db.select(_db.transactions).join([
      innerJoin(_db.userWallets, _db.userWallets.id.equalsExp(_db.transactions.walletId)),
    ]);

    // 2. Filter by the specific User
    query.where(_db.userWallets.userId.equals(userId));

    // 3. Order by Newest First
    query.orderBy([OrderingTerm.desc(_db.transactions.transactionDate)]);

    // 4. Watch the stream (Reactive!)
    return query.watch().map((rows) {
      return rows.map((row) => row.readTable(_db.transactions)).toList();
    });
  }

  // 2. Add a new wallet
  Future<void> addWallet(
    String name,
    double balance,
    String? lastFourDigits,
    String holderName,
    int userId,
  ) async {
    await _db
        .into(_db.userWallets)
        .insert(
          UserWalletsCompanion.insert(
            walletName: name,
            holderName: holderName,
            lastFourDigit: Value(lastFourDigits),
            walletBalance: Value(balance),
            userId: userId,
          ),
        );
  }

  Future<void> addIncome(
    int walletId,
    double amount,
    String description,
    String category,
    DateTime date,
  ) async {
    // 1. Fetch the specific wallet using the ID
    final currentWallet =
        await (_db.select(_db.userWallets)..where((tbl) => tbl.id.equals(walletId))).getSingle();

    // 2. Calculate the new balance
    final newBalance = currentWallet.walletBalance + amount;

    // 3. Update the database
    // We use a 'Companion' to update only the specific field (walletBalance)
    await (_db.update(_db.userWallets)..where(
      (tbl) => tbl.id.equals(walletId),
    )).write(UserWalletsCompanion(walletBalance: Value(newBalance)));

    await _db
        .into(_db.transactions)
        .insert(
          TransactionsCompanion.insert(
            walletId: walletId,
            type: 'INCOME',
            category: category,
            description: description,
            transactionDate: date,
            amount: Value(amount),
          ),
        );
  }

  Future<void> addExpense(
    int walletId,
    double amount,
    String description,
    String category,
    DateTime date,
  ) async {
    final currentWallet =
        await (_db.select(_db.userWallets)..where((tbl) => tbl.id.equals(walletId))).getSingle();
    final newBalance = currentWallet.walletBalance - amount;

    await (_db.update(_db.userWallets)..where(
      (tbl) => tbl.id.equals(walletId),
    )).write(UserWalletsCompanion(walletBalance: Value(newBalance)));

    await _db
        .into(_db.transactions)
        .insert(
          TransactionsCompanion.insert(
            walletId: walletId,
            type: 'EXPENSE',
            category: category,
            description: description,
            transactionDate: date,
            amount: Value(amount),
          ),
        );
  }

  Future<void> deleteWallet(int id) async {
    await _db.deleteWallet(id);
  }

  Future<void> updateWallet(UserWallet wallet) async {
    await _db.updateWallet(wallet);
  }

  Future<void> deleteTransaction(int transactionId) async {
    // 1. Find the transaction first (so we know the Amount and Type)
    final transaction = await (_db.select(_db.transactions)
      ..where((t) => t.id.equals(transactionId))).getSingle();

    // 2. Find the specific Wallet involved
    final wallet = await (_db.select(_db.userWallets)
      ..where((w) => w.id.equals(transaction.walletId))).getSingle();

    // 3. Calculate the new balance (Reverse the transaction)
    double currentBalance = wallet.walletBalance;
    double newBalance = currentBalance;

    if (transaction.type == 'INCOME') {
      // If we delete Income, REMOVE money from wallet
      newBalance = currentBalance - transaction.amount;
    } else {
      // If we delete Expense, RETURN money to wallet
      newBalance = currentBalance + transaction.amount;
    }

    // 4. Update the Wallet Balance
    await updateWallet(wallet.copyWith(walletBalance: newBalance));

    // 5. Finally, delete the transaction record
    await _db.deleteTransaction(transactionId);
  }
}
