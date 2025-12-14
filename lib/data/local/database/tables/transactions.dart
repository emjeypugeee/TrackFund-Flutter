import 'package:drift/drift.dart';
import 'package:track_fund/data/local/database/tables/user_wallets.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  // 1. Link to Wallet
  IntColumn get walletId => integer().references(UserWallets, #id)();

  // 2. Type: 'INCOME' or 'EXPENSE'
  TextColumn get type => text().withLength(min: 1, max: 10)();

  // 3. Amount
  RealColumn get amount => real().withDefault(const Constant(0.0))();

  // 4. Category (e.g., "Food", "Salary")
  // This will be your "main" label in some views if description is empty
  TextColumn get category => text().withLength(min: 1, max: 30)();

  // 5. Description (The input from your form)
  // I removed .nullable() because your form validator requires it anyway.
  // This holds "Lunch at Jollibee" or "Taxi to work"
  TextColumn get description => text().withLength(min: 1, max: 100)();

  // 6. Date
  DateTimeColumn get transactionDate => dateTime()();
}