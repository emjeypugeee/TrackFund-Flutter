import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_fund/components/main_pages_widgets/home_page/theme_toggle_button.dart';
import 'package:track_fund/components/user_details_widgets/add_wallet_container.dart';
import 'package:track_fund/components/custom_button.dart';
import 'package:track_fund/components/user_details_widgets/wallet_mock_list.dart';
import 'package:track_fund/router/app_router.dart';

class UserDetailsPage1 extends StatelessWidget {
  const UserDetailsPage1({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [ThemeToggleButton()]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add your wallets',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),

            const AddWalletContainer(),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your Wallets",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Expanded(child: WalletList()),

            // -----------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Get Started!',
                  onTap: () => context.push(AppRouter.userDetails2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
