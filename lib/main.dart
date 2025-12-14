import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/data/repositories/user_data_repositories.dart';
import 'package:track_fund/data/repositories/wallet_repositories.dart';
import 'package:track_fund/logic/blocs/sign_up/sign_up_cubit.dart';
import 'package:track_fund/logic/blocs/themes/theme_cubit.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_bloc.dart';
import 'package:track_fund/logic/blocs/user/user_bloc.dart';
import 'package:track_fund/logic/blocs/user_wallets/wallet_bloc.dart';
import 'package:track_fund/router/app_router.dart';
import 'package:track_fund/theme/app_theme.dart';

// 1. GLOBAL VARIABLE (This was staying empty before)
late AppDatabase database;

void main() {
  // Optional but recommended: Ensures Flutter is ready before DB starts
  WidgetsFlutterBinding.ensureInitialized();

  // 2. THE FIX: Removed 'final'
  // Now we are assigning the value to the global variable above.
  database = AppDatabase();

  final walletRepo = WalletRepository(database);
  final userRepo = UserDataRepositories(database); // Create this here

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit(walletRepo, userRepo)),
        BlocProvider(create: (context) => WalletBloc(walletRepo)),
        BlocProvider(create: (context) => UserBloc(userRepo)..add(CheckSession())),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => TransactionBloc(walletRepo)),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeModeState) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          themeMode: themeModeState,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}
