import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_fund/components/custom_button.dart';
import 'package:track_fund/components/main_pages_widgets/home_page/theme_toggle_button.dart';
import 'package:track_fund/router/app_router.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [ThemeToggleButton()]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 200,
                    child: Image.asset('assets/images/track_fund_logo.png'),
                  ),
                  Text(
                    'Save your money expenses with Track-Fund',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Get Money! Track Money! Save Money! \nYou\'re one stop solution on your expenses tracker problems.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.onSurface.withValues(alpha: 0.6), fontSize: 16),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(text: 'Get Started!', onTap: () => context.go(AppRouter.login)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
