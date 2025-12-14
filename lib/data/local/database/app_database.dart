import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

//TABLES
import 'package:track_fund/data/local/database/tables/users.dart';
import 'package:track_fund/data/local/database/tables/user_wallets.dart';
import 'package:track_fund/data/local/database/tables/transactions.dart';

part 'app_database.g.dart';

// 2. REGISTER THE NEW TABLE HERE
@DriftDatabase(tables: [Users, UserWallets, Transactions]) // <--- ADD UserWallets HERE
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // 3. CHANGE VERSION IF APP IS ALREADY INSTALLED
  @override
  int get schemaVersion => 5; // Set to 1 if this is a fresh install/uninstall

  Future<int> deleteWallet(int id) {
    return (delete(userWallets)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateWallet(UserWallet entry) {
    return update(userWallets).replace(entry);
  }

  Future<int> deleteTransaction(int id) {
    return (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateTransaction(Transaction entry) {
    return update(transactions).replace(entry);
  }

  Stream<List<UserWallet>> getWallets(int userId) {
    return (select(userWallets)..where((tbl) => tbl.userId.equals(userId))).watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
