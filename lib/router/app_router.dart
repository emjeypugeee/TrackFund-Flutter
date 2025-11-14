import 'package:go_router/go_router.dart';
import 'package:track_fund/components/custom_bottom_nav.dart';
import 'package:track_fund/pages/home_page.dart';
import 'package:track_fund/pages/payment_page.dart';
import 'package:track_fund/pages/profile_page.dart';
import 'package:track_fund/pages/startup_page.dart';
import 'package:track_fund/pages/wallet_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/', builder: (context, state) => StartupPage()),
      ShellRoute(
        builder: (context, state, child) => CustomBottomNav(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => HomePage()),
          GoRoute(path: '/wallet', builder: (context, state) => WalletPage()),
          GoRoute(path: '/payment', builder: (context, state) => PaymentPage()),
          GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
        ],
      ),
    ],
  );
}
