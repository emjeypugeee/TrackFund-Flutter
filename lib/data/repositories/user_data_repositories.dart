import 'package:track_fund/data/local/database/app_database.dart';
import 'package:drift/drift.dart';

class UserDataRepositories {
  final AppDatabase _db;

  UserDataRepositories(this._db);

  Stream<List<User>> getUserData() {
    return _db.select(_db.users).watch();
  }

  Future<int> createUser(UsersCompanion newUser) {
    return _db.into(_db.users).insert(newUser);
  }

  Future<int> createUserAndReturnId(UsersCompanion newUser) {
    return createUser(newUser);
  }

  Future<User?> loginUser(String username, String password) async {
    return await (_db.select(_db.users)..where(
      (tbl) => tbl.username.equals(username) & tbl.password.equals(password),
    )).getSingleOrNull();
  }

  Future<User?> getUserById(int id) async {
    return await (_db.select(_db.users)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
