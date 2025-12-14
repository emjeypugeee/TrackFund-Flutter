import 'package:drift/drift.dart';
import 'package:track_fund/data/local/database/tables/users.dart';

// The class name must be UserWallets (Plural)
class UserWallets extends Table {
  // 1. Auto-incrementing ID
  IntColumn get id => integer().autoIncrement()();

  // 2. Name of the wallet (e.g., "GCash")
  TextColumn get walletName => text().withLength(min: 1, max: 50)();

  TextColumn get holderName => text().withLength(min: 1, max: 50)();

  TextColumn get lastFourDigit => text().withLength(min: 4, max: 4).nullable()();

  // 3. Balance (using Real for money)
  RealColumn get walletBalance => real().withDefault(const Constant(0.0))();

  IntColumn get userId => integer().references(Users, #id)();
}
