import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  // user columns
  TextColumn get username => text()();
  TextColumn get password => text()();
  TextColumn get email => text()();
  TextColumn get contact => text()();
}
