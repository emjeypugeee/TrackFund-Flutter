import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_fund/components/custom_button.dart';
import 'package:track_fund/components/user_details_widgets/user_wallet_button.dart';
import 'package:track_fund/router/app_router.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final List<Map<String, dynamic>> incomeSources = [
    {'label': 'Business', 'icon': Icons.store},
    {'label': 'Salary', 'icon': Icons.attach_money},
    {'label': 'Freelance', 'icon': Icons.computer},
    {'label': 'Investments', 'icon': Icons.trending_up},
    {'label': 'Allowance', 'icon': Icons.family_restroom},
    {'label': 'Other', 'icon': Icons.category},
  ];

  final Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Setting up your wallets...', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              'Where does your income come from?',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: screenHeight * 0.03),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.3,
                ),
                itemCount: incomeSources.length,
                itemBuilder: (context, index) {
                  // Check if this specific index is inside our Set of selected items
                  final isSelected = selectedIndices.contains(index);

                  return UserWalletButton(
                    label: incomeSources[index]['label'],
                    icon: incomeSources[index]['icon'],
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedIndices.remove(index);
                        } else {
                          selectedIndices.add(index);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            CustomButton(
              text: 'Next',
              onTap: () async {
                if (selectedIndices.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select your wallets'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  context.push(AppRouter.userDetails1);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
