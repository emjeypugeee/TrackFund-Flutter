import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:track_fund/components/main_pages_widgets/add_expenses_form.dart';
import 'package:track_fund/components/main_pages_widgets/add_income_form.dart';
import 'package:track_fund/components/main_pages_widgets/home_page/theme_toggle_button.dart';
import 'package:track_fund/router/app_router.dart';

class CustomBottomNav extends StatelessWidget {
  final Widget child;

  const CustomBottomNav({super.key, required this.child});

  void _showAddExpenses(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddExpensesForm(),
    );
  }

  void _showAddIncome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddIncomeForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = _calculateSelectedIndex(context);

    //Define data structure for tabs to avoid code repetition
    final navItems = [
      (index: 0, icon: Icons.home, route: AppRouter.home, label: 'Home'),
      (index: 1, icon: Icons.analytics_outlined, route: AppRouter.analytics, label: 'Overview'),
      (index: 2, icon: Icons.wallet, route: AppRouter.wallet, label: 'Wallet'),
      (index: 3, icon: Icons.person, route: AppRouter.profile, label: 'Profile'),
    ];

    final currentTitle = navItems[currentIndex].label;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: Text(currentTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [const ThemeToggleButton()],
      ),
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        iconTheme: const IconThemeData(color: Colors.black),
        activeIcon: Icons.close,
        backgroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.attach_money_rounded),
            label: 'Add Income',
            backgroundColor: Colors.green,
            onTap: () => _showAddIncome(context),
          ),
          SpeedDialChild(
            child: const Icon(Icons.money_off_csred_rounded),
            label: 'Add Expenses',
            backgroundColor: Colors.red,
            onTap: () => _showAddExpenses(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0, // Increased slightly for better visual separation
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...navItems
                .take(2)
                .map(
                  (item) => _buildNavIcon(
                    context: context,
                    item: item,
                    isSelected: currentIndex == item.index,
                  ),
                ),

            const SizedBox(width: 48),

            ...navItems
                .skip(2)
                .map(
                  (item) => _buildNavIcon(
                    context: context,
                    item: item,
                    isSelected: currentIndex == item.index,
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon({
    required BuildContext context,
    required ({IconData icon, int index, String label, String route}) item,
    required bool isSelected,
  }) {
    final colors = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(item.icon),
      tooltip: item.label,
      color: isSelected ? colors.primary : Colors.grey,
      iconSize: 26,
      onPressed: () => context.go(item.route),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppRouter.home)) return 0;
    if (location.startsWith(AppRouter.analytics)) return 1;
    if (location.startsWith(AppRouter.wallet)) return 2;
    if (location.startsWith(AppRouter.profile)) return 3;
    return 0;
  }
}
