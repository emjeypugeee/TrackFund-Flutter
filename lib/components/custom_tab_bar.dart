import 'package:flutter/material.dart';

enum TabType { income, expenses }

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  // FIX 1: Link to CustomTabBar
  State<CustomTabBar> createState() => _TabBarState();
}

// FIX 2: Link to CustomTabBar
class _TabBarState extends State<CustomTabBar> {
  // FIX 3: Move variable outside the build method
  TabType selectedTab = TabType.expenses;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          // --- INCOME TAB ---
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = TabType.income;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color:
                      selectedTab == TabType.income
                          ? Colors
                              .deepPurpleAccent // Selected color
                          : Colors.transparent, // Unselected color
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Income',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selectedTab == TabType.income ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // --- EXPENSES TAB ---
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // FIX 4: Change to .expenses
                  selectedTab = TabType.expenses;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  // FIX 5: Check for .expenses
                  color:
                      selectedTab == TabType.expenses
                          ? Colors
                              .orange // Selected color (from your image)
                          : Colors.transparent, // Unselected color
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Expenses',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // FIX 6: Check for .expenses and set text color
                      color: selectedTab == TabType.expenses ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
