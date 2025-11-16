import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNav extends StatelessWidget {
  final Widget child;
  const CustomBottomNav({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // 1. Get the currently selected index
    final int currentIndex = _calculateSelectedIndex(context);
    List<String> titles = ['Home', 'Overview', 'Wallet', 'Profile'];

    // 2. Define colors for active/inactive tabs
    final Color selectedColor = Colors.deepPurpleAccent;
    final Color unselectedColor = Colors.grey;

    //
    double iconSize = 25;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, size: iconSize),
            (Text(titles[currentIndex], style: TextStyle(fontWeight: FontWeight.bold))),
            Icon(Icons.notifications, size: iconSize),
          ],
        ),
      ),
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // 3. Wire up the FAB (or leave for a separate action)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        shape: CircleBorder(),
        onPressed: () {
          // This button is separate from the shell routes.
          // You could use it to navigate to a "create post" page, e.g.:
          // context.push('/create');
        },
        child: const Icon(Icons.add, color: Colors.white), // Changed icon to 'add' for clarity
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0, // Adds a nice gap around the FAB
        child: Row(
          // 4. Space around works well with a center FAB
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // --- HOME ---
            IconButton(
              icon: const Icon(Icons.home),
              // 5. Set color based on active index
              color: currentIndex == 0 ? selectedColor : unselectedColor,
              // 6. Call navigation helper on press
              onPressed: () => _onItemTapped(0, context),
              iconSize: iconSize,
            ),
            // --- WALLET ---
            IconButton(
              icon: const Icon(Icons.analytics_outlined),
              color: currentIndex == 1 ? selectedColor : unselectedColor,
              onPressed: () => _onItemTapped(1, context),
              iconSize: iconSize,
            ),
            // --- PAYMENT ---
            // Note: Your original code had 4 icons. I've matched them
            // to your 4 routes.
            IconButton(
              icon: const Icon(Icons.wallet), // Your 'wallet' icon
              color: currentIndex == 2 ? selectedColor : unselectedColor,
              onPressed: () => _onItemTapped(2, context),
              iconSize: iconSize,
            ),
            // --- PROFILE ---
            IconButton(
              icon: const Icon(Icons.person),
              color: currentIndex == 3 ? selectedColor : unselectedColor,
              onPressed: () => _onItemTapped(3, context),
              iconSize: iconSize,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to handle navigation
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/wallet');
        break;
      case 2:
        context.go('/payment');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  // Helper method to determine the selected index based on the current route
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/wallet')) {
      return 1;
    }
    if (location.startsWith('/payment')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    return 0;
  }
}
