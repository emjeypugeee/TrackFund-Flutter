import 'package:go_router/go_router.dart';
import 'package:track_fund/components/custom_bottom_nav.dart';
import 'package:track_fund/pages/main_pages/home_page.dart';
import 'package:track_fund/pages/user_details_pages/login_page.dart';
import 'package:track_fund/pages/user_details_pages/user_details_page.dart';
import 'package:track_fund/pages/user_details_pages/user_details_page1.dart';
import 'package:track_fund/pages/user_details_pages/user_details_page2.dart';
import 'package:track_fund/pages/main_pages/wallet_page.dart';
import 'package:track_fund/pages/main_pages/profile_page.dart';
import 'package:track_fund/pages/user_details_pages/startup_page.dart';
import 'package:track_fund/pages/main_pages/analytics_page.dart';

class AppRouter {
  static const String startup = '/';
  static const String login = '/login';
  static const String userDetails = '/user';
  static const String userDetails1 = '/user1';
  static const String userDetails2 = '/user2';

  static const String home = '/home';
  static const String wallet = '/wallet';
  static const String analytics = '/analytics';
  static const String profile = '/profile';
  
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => StartupPage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/user', builder: (context, state) => UserDetailsPage()),
      GoRoute(path: '/user1', builder: (context, state) => UserDetailsPage1()),
      GoRoute(path: '/user2', builder: (context, state) => UserDetailsPage2()),
      ShellRoute(
        builder: (context, state, child) => CustomBottomNav(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => HomePage()),
          GoRoute(path: '/wallet', builder: (context, state) => WalletPage()),
          GoRoute(path: '/analytics', builder: (context, state) => AnalyticsPage()),
          GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
        ],
      ),
    ],
  );
}
