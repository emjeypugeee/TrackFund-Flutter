// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactMeta = const VerificationMeta(
    'contact',
  );
  @override
  late final GeneratedColumn<String> contact = GeneratedColumn<String>(
    'contact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    password,
    email,
    contact,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('contact')) {
      context.handle(
        _contactMeta,
        contact.isAcceptableOrUnknown(data['contact']!, _contactMeta),
      );
    } else if (isInserting) {
      context.missing(_contactMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      username:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}username'],
          )!,
      password:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}password'],
          )!,
      email:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}email'],
          )!,
      contact:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}contact'],
          )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  final String email;
  final String contact;
  const User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.contact,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['email'] = Variable<String>(email);
    map['contact'] = Variable<String>(contact);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      email: Value(email),
      contact: Value(contact),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      email: serializer.fromJson<String>(json['email']),
      contact: serializer.fromJson<String>(json['contact']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'email': serializer.toJson<String>(email),
      'contact': serializer.toJson<String>(contact),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? contact,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
    email: email ?? this.email,
    contact: contact ?? this.contact,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      email: data.email.present ? data.email.value : this.email,
      contact: data.contact.present ? data.contact.value : this.contact,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('email: $email, ')
          ..write('contact: $contact')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, email, contact);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.email == this.email &&
          other.contact == this.contact);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> email;
  final Value<String> contact;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.contact = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    required String email,
    required String contact,
  }) : username = Value(username),
       password = Value(password),
       email = Value(email),
       contact = Value(contact);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? email,
    Expression<String>? contact,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (contact != null) 'contact': contact,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? password,
    Value<String>? email,
    Value<String>? contact,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      contact: contact ?? this.contact,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (contact.present) {
      map['contact'] = Variable<String>(contact.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('email: $email, ')
          ..write('contact: $contact')
          ..write(')'))
        .toString();
  }
}

class $UserWalletsTable extends UserWallets
    with TableInfo<$UserWalletsTable, UserWallet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserWalletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _walletNameMeta = const VerificationMeta(
    'walletName',
  );
  @override
  late final GeneratedColumn<String> walletName = GeneratedColumn<String>(
    'wallet_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _holderNameMeta = const VerificationMeta(
    'holderName',
  );
  @override
  late final GeneratedColumn<String> holderName = GeneratedColumn<String>(
    'holder_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastFourDigitMeta = const VerificationMeta(
    'lastFourDigit',
  );
  @override
  late final GeneratedColumn<String> lastFourDigit = GeneratedColumn<String>(
    'last_four_digit',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 4,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _walletBalanceMeta = const VerificationMeta(
    'walletBalance',
  );
  @override
  late final GeneratedColumn<double> walletBalance = GeneratedColumn<double>(
    'wallet_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    walletName,
    holderName,
    lastFourDigit,
    walletBalance,
    userId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_wallets';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserWallet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wallet_name')) {
      context.handle(
        _walletNameMeta,
        walletName.isAcceptableOrUnknown(data['wallet_name']!, _walletNameMeta),
      );
    } else if (isInserting) {
      context.missing(_walletNameMeta);
    }
    if (data.containsKey('holder_name')) {
      context.handle(
        _holderNameMeta,
        holderName.isAcceptableOrUnknown(data['holder_name']!, _holderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_holderNameMeta);
    }
    if (data.containsKey('last_four_digit')) {
      context.handle(
        _lastFourDigitMeta,
        lastFourDigit.isAcceptableOrUnknown(
          data['last_four_digit']!,
          _lastFourDigitMeta,
        ),
      );
    }
    if (data.containsKey('wallet_balance')) {
      context.handle(
        _walletBalanceMeta,
        walletBalance.isAcceptableOrUnknown(
          data['wallet_balance']!,
          _walletBalanceMeta,
        ),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserWallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserWallet(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      walletName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}wallet_name'],
          )!,
      holderName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}holder_name'],
          )!,
      lastFourDigit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_four_digit'],
      ),
      walletBalance:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}wallet_balance'],
          )!,
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_id'],
          )!,
    );
  }

  @override
  $UserWalletsTable createAlias(String alias) {
    return $UserWalletsTable(attachedDatabase, alias);
  }
}

class UserWallet extends DataClass implements Insertable<UserWallet> {
  final int id;
  final String walletName;
  final String holderName;
  final String? lastFourDigit;
  final double walletBalance;
  final int userId;
  const UserWallet({
    required this.id,
    required this.walletName,
    required this.holderName,
    this.lastFourDigit,
    required this.walletBalance,
    required this.userId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wallet_name'] = Variable<String>(walletName);
    map['holder_name'] = Variable<String>(holderName);
    if (!nullToAbsent || lastFourDigit != null) {
      map['last_four_digit'] = Variable<String>(lastFourDigit);
    }
    map['wallet_balance'] = Variable<double>(walletBalance);
    map['user_id'] = Variable<int>(userId);
    return map;
  }

  UserWalletsCompanion toCompanion(bool nullToAbsent) {
    return UserWalletsCompanion(
      id: Value(id),
      walletName: Value(walletName),
      holderName: Value(holderName),
      lastFourDigit:
          lastFourDigit == null && nullToAbsent
              ? const Value.absent()
              : Value(lastFourDigit),
      walletBalance: Value(walletBalance),
      userId: Value(userId),
    );
  }

  factory UserWallet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserWallet(
      id: serializer.fromJson<int>(json['id']),
      walletName: serializer.fromJson<String>(json['walletName']),
      holderName: serializer.fromJson<String>(json['holderName']),
      lastFourDigit: serializer.fromJson<String?>(json['lastFourDigit']),
      walletBalance: serializer.fromJson<double>(json['walletBalance']),
      userId: serializer.fromJson<int>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'walletName': serializer.toJson<String>(walletName),
      'holderName': serializer.toJson<String>(holderName),
      'lastFourDigit': serializer.toJson<String?>(lastFourDigit),
      'walletBalance': serializer.toJson<double>(walletBalance),
      'userId': serializer.toJson<int>(userId),
    };
  }

  UserWallet copyWith({
    int? id,
    String? walletName,
    String? holderName,
    Value<String?> lastFourDigit = const Value.absent(),
    double? walletBalance,
    int? userId,
  }) => UserWallet(
    id: id ?? this.id,
    walletName: walletName ?? this.walletName,
    holderName: holderName ?? this.holderName,
    lastFourDigit:
        lastFourDigit.present ? lastFourDigit.value : this.lastFourDigit,
    walletBalance: walletBalance ?? this.walletBalance,
    userId: userId ?? this.userId,
  );
  UserWallet copyWithCompanion(UserWalletsCompanion data) {
    return UserWallet(
      id: data.id.present ? data.id.value : this.id,
      walletName:
          data.walletName.present ? data.walletName.value : this.walletName,
      holderName:
          data.holderName.present ? data.holderName.value : this.holderName,
      lastFourDigit:
          data.lastFourDigit.present
              ? data.lastFourDigit.value
              : this.lastFourDigit,
      walletBalance:
          data.walletBalance.present
              ? data.walletBalance.value
              : this.walletBalance,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserWallet(')
          ..write('id: $id, ')
          ..write('walletName: $walletName, ')
          ..write('holderName: $holderName, ')
          ..write('lastFourDigit: $lastFourDigit, ')
          ..write('walletBalance: $walletBalance, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    walletName,
    holderName,
    lastFourDigit,
    walletBalance,
    userId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserWallet &&
          other.id == this.id &&
          other.walletName == this.walletName &&
          other.holderName == this.holderName &&
          other.lastFourDigit == this.lastFourDigit &&
          other.walletBalance == this.walletBalance &&
          other.userId == this.userId);
}

class UserWalletsCompanion extends UpdateCompanion<UserWallet> {
  final Value<int> id;
  final Value<String> walletName;
  final Value<String> holderName;
  final Value<String?> lastFourDigit;
  final Value<double> walletBalance;
  final Value<int> userId;
  const UserWalletsCompanion({
    this.id = const Value.absent(),
    this.walletName = const Value.absent(),
    this.holderName = const Value.absent(),
    this.lastFourDigit = const Value.absent(),
    this.walletBalance = const Value.absent(),
    this.userId = const Value.absent(),
  });
  UserWalletsCompanion.insert({
    this.id = const Value.absent(),
    required String walletName,
    required String holderName,
    this.lastFourDigit = const Value.absent(),
    this.walletBalance = const Value.absent(),
    required int userId,
  }) : walletName = Value(walletName),
       holderName = Value(holderName),
       userId = Value(userId);
  static Insertable<UserWallet> custom({
    Expression<int>? id,
    Expression<String>? walletName,
    Expression<String>? holderName,
    Expression<String>? lastFourDigit,
    Expression<double>? walletBalance,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (walletName != null) 'wallet_name': walletName,
      if (holderName != null) 'holder_name': holderName,
      if (lastFourDigit != null) 'last_four_digit': lastFourDigit,
      if (walletBalance != null) 'wallet_balance': walletBalance,
      if (userId != null) 'user_id': userId,
    });
  }

  UserWalletsCompanion copyWith({
    Value<int>? id,
    Value<String>? walletName,
    Value<String>? holderName,
    Value<String?>? lastFourDigit,
    Value<double>? walletBalance,
    Value<int>? userId,
  }) {
    return UserWalletsCompanion(
      id: id ?? this.id,
      walletName: walletName ?? this.walletName,
      holderName: holderName ?? this.holderName,
      lastFourDigit: lastFourDigit ?? this.lastFourDigit,
      walletBalance: walletBalance ?? this.walletBalance,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (walletName.present) {
      map['wallet_name'] = Variable<String>(walletName.value);
    }
    if (holderName.present) {
      map['holder_name'] = Variable<String>(holderName.value);
    }
    if (lastFourDigit.present) {
      map['last_four_digit'] = Variable<String>(lastFourDigit.value);
    }
    if (walletBalance.present) {
      map['wallet_balance'] = Variable<double>(walletBalance.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserWalletsCompanion(')
          ..write('id: $id, ')
          ..write('walletName: $walletName, ')
          ..write('holderName: $holderName, ')
          ..write('lastFourDigit: $lastFourDigit, ')
          ..write('walletBalance: $walletBalance, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<int> walletId = GeneratedColumn<int>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_wallets (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    walletId,
    type,
    amount,
    category,
    description,
    transactionDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walletIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      walletId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}wallet_id'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount'],
          )!,
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      transactionDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}transaction_date'],
          )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int walletId;
  final String type;
  final double amount;
  final String category;
  final String description;
  final DateTime transactionDate;
  const Transaction({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.category,
    required this.description,
    required this.transactionDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wallet_id'] = Variable<int>(walletId);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      walletId: Value(walletId),
      type: Value(type),
      amount: Value(amount),
      category: Value(category),
      description: Value(description),
      transactionDate: Value(transactionDate),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      walletId: serializer.fromJson<int>(json['walletId']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'walletId': serializer.toJson<int>(walletId),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
    };
  }

  Transaction copyWith({
    int? id,
    int? walletId,
    String? type,
    double? amount,
    String? category,
    String? description,
    DateTime? transactionDate,
  }) => Transaction(
    id: id ?? this.id,
    walletId: walletId ?? this.walletId,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    category: category ?? this.category,
    description: description ?? this.description,
    transactionDate: transactionDate ?? this.transactionDate,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      transactionDate:
          data.transactionDate.present
              ? data.transactionDate.value
              : this.transactionDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('walletId: $walletId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('transactionDate: $transactionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    walletId,
    type,
    amount,
    category,
    description,
    transactionDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.walletId == this.walletId &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.description == this.description &&
          other.transactionDate == this.transactionDate);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> walletId;
  final Value<String> type;
  final Value<double> amount;
  final Value<String> category;
  final Value<String> description;
  final Value<DateTime> transactionDate;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.walletId = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.transactionDate = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int walletId,
    required String type,
    this.amount = const Value.absent(),
    required String category,
    required String description,
    required DateTime transactionDate,
  }) : walletId = Value(walletId),
       type = Value(type),
       category = Value(category),
       description = Value(description),
       transactionDate = Value(transactionDate);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? walletId,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? description,
    Expression<DateTime>? transactionDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (walletId != null) 'wallet_id': walletId,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (transactionDate != null) 'transaction_date': transactionDate,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? walletId,
    Value<String>? type,
    Value<double>? amount,
    Value<String>? category,
    Value<String>? description,
    Value<DateTime>? transactionDate,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (walletId.present) {
      map['wallet_id'] = Variable<int>(walletId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('walletId: $walletId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('transactionDate: $transactionDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $UserWalletsTable userWallets = $UserWalletsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    userWallets,
    transactions,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String password,
      required String email,
      required String contact,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> password,
      Value<String> email,
      Value<String> contact,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserWalletsTable, List<UserWallet>>
  _userWalletsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userWallets,
    aliasName: $_aliasNameGenerator(db.users.id, db.userWallets.userId),
  );

  $$UserWalletsTableProcessedTableManager get userWalletsRefs {
    final manager = $$UserWalletsTableTableManager(
      $_db,
      $_db.userWallets,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userWalletsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contact => $composableBuilder(
    column: $table.contact,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userWalletsRefs(
    Expression<bool> Function($$UserWalletsTableFilterComposer f) f,
  ) {
    final $$UserWalletsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userWallets,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserWalletsTableFilterComposer(
            $db: $db,
            $table: $db.userWallets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contact => $composableBuilder(
    column: $table.contact,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get contact =>
      $composableBuilder(column: $table.contact, builder: (column) => column);

  Expression<T> userWalletsRefs<T extends Object>(
    Expression<T> Function($$UserWalletsTableAnnotationComposer a) f,
  ) {
    final $$UserWalletsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userWallets,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserWalletsTableAnnotationComposer(
            $db: $db,
            $table: $db.userWallets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool userWalletsRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> contact = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                password: password,
                email: email,
                contact: contact,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String password,
                required String email,
                required String contact,
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                password: password,
                email: email,
                contact: contact,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$UsersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userWalletsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (userWalletsRefs) db.userWallets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userWalletsRefs)
                    await $_getPrefetchedData<User, $UsersTable, UserWallet>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._userWalletsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).userWalletsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool userWalletsRefs})
    >;
typedef $$UserWalletsTableCreateCompanionBuilder =
    UserWalletsCompanion Function({
      Value<int> id,
      required String walletName,
      required String holderName,
      Value<String?> lastFourDigit,
      Value<double> walletBalance,
      required int userId,
    });
typedef $$UserWalletsTableUpdateCompanionBuilder =
    UserWalletsCompanion Function({
      Value<int> id,
      Value<String> walletName,
      Value<String> holderName,
      Value<String?> lastFourDigit,
      Value<double> walletBalance,
      Value<int> userId,
    });

final class $$UserWalletsTableReferences
    extends BaseReferences<_$AppDatabase, $UserWalletsTable, UserWallet> {
  $$UserWalletsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.userWallets.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: $_aliasNameGenerator(
      db.userWallets.id,
      db.transactions.walletId,
    ),
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.walletId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserWalletsTableFilterComposer
    extends Composer<_$AppDatabase, $UserWalletsTable> {
  $$UserWalletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walletName => $composableBuilder(
    column: $table.walletName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastFourDigit => $composableBuilder(
    column: $table.lastFourDigit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get walletBalance => $composableBuilder(
    column: $table.walletBalance,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserWalletsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserWalletsTable> {
  $$UserWalletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walletName => $composableBuilder(
    column: $table.walletName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastFourDigit => $composableBuilder(
    column: $table.lastFourDigit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get walletBalance => $composableBuilder(
    column: $table.walletBalance,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserWalletsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserWalletsTable> {
  $$UserWalletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get walletName => $composableBuilder(
    column: $table.walletName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastFourDigit => $composableBuilder(
    column: $table.lastFourDigit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get walletBalance => $composableBuilder(
    column: $table.walletBalance,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserWalletsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserWalletsTable,
          UserWallet,
          $$UserWalletsTableFilterComposer,
          $$UserWalletsTableOrderingComposer,
          $$UserWalletsTableAnnotationComposer,
          $$UserWalletsTableCreateCompanionBuilder,
          $$UserWalletsTableUpdateCompanionBuilder,
          (UserWallet, $$UserWalletsTableReferences),
          UserWallet,
          PrefetchHooks Function({bool userId, bool transactionsRefs})
        > {
  $$UserWalletsTableTableManager(_$AppDatabase db, $UserWalletsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UserWalletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UserWalletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$UserWalletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> walletName = const Value.absent(),
                Value<String> holderName = const Value.absent(),
                Value<String?> lastFourDigit = const Value.absent(),
                Value<double> walletBalance = const Value.absent(),
                Value<int> userId = const Value.absent(),
              }) => UserWalletsCompanion(
                id: id,
                walletName: walletName,
                holderName: holderName,
                lastFourDigit: lastFourDigit,
                walletBalance: walletBalance,
                userId: userId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String walletName,
                required String holderName,
                Value<String?> lastFourDigit = const Value.absent(),
                Value<double> walletBalance = const Value.absent(),
                required int userId,
              }) => UserWalletsCompanion.insert(
                id: id,
                walletName: walletName,
                holderName: holderName,
                lastFourDigit: lastFourDigit,
                walletBalance: walletBalance,
                userId: userId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$UserWalletsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userId = false, transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (userId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$UserWalletsTableReferences
                                ._userIdTable(db),
                            referencedColumn:
                                $$UserWalletsTableReferences
                                    ._userIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      UserWallet,
                      $UserWalletsTable,
                      Transaction
                    >(
                      currentTable: table,
                      referencedTable: $$UserWalletsTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$UserWalletsTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.walletId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UserWalletsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserWalletsTable,
      UserWallet,
      $$UserWalletsTableFilterComposer,
      $$UserWalletsTableOrderingComposer,
      $$UserWalletsTableAnnotationComposer,
      $$UserWalletsTableCreateCompanionBuilder,
      $$UserWalletsTableUpdateCompanionBuilder,
      (UserWallet, $$UserWalletsTableReferences),
      UserWallet,
      PrefetchHooks Function({bool userId, bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required int walletId,
      required String type,
      Value<double> amount,
      required String category,
      required String description,
      required DateTime transactionDate,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<int> walletId,
      Value<String> type,
      Value<double> amount,
      Value<String> category,
      Value<String> description,
      Value<DateTime> transactionDate,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserWalletsTable _walletIdTable(_$AppDatabase db) =>
      db.userWallets.createAlias(
        $_aliasNameGenerator(db.transactions.walletId, db.userWallets.id),
      );

  $$UserWalletsTableProcessedTableManager get walletId {
    final $_column = $_itemColumn<int>('wallet_id')!;

    final manager = $$UserWalletsTableTableManager(
      $_db,
      $_db.userWallets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_walletIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  $$UserWalletsTableFilterComposer get walletId {
    final $$UserWalletsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.userWallets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserWalletsTableFilterComposer(
            $db: $db,
            $table: $db.userWallets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserWalletsTableOrderingComposer get walletId {
    final $$UserWalletsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.userWallets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserWalletsTableOrderingComposer(
            $db: $db,
            $table: $db.userWallets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  $$UserWalletsTableAnnotationComposer get walletId {
    final $$UserWalletsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.userWallets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserWalletsTableAnnotationComposer(
            $db: $db,
            $table: $db.userWallets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({bool walletId})
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> walletId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                walletId: walletId,
                type: type,
                amount: amount,
                category: category,
                description: description,
                transactionDate: transactionDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int walletId,
                required String type,
                Value<double> amount = const Value.absent(),
                required String category,
                required String description,
                required DateTime transactionDate,
              }) => TransactionsCompanion.insert(
                id: id,
                walletId: walletId,
                type: type,
                amount: amount,
                category: category,
                description: description,
                transactionDate: transactionDate,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TransactionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({walletId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (walletId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.walletId,
                            referencedTable: $$TransactionsTableReferences
                                ._walletIdTable(db),
                            referencedColumn:
                                $$TransactionsTableReferences
                                    ._walletIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({bool walletId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$UserWalletsTableTableManager get userWallets =>
      $$UserWalletsTableTableManager(_db, _db.userWallets);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
