import 'package:flutter/material.dart';
import 'package:track_fund/components/custom_card.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomCard(),
            SizedBox(height: screenHeight * 0.02),
            CustomCard(),
            SizedBox(height: screenHeight * 0.02),
            CustomCard(),
          ],
        ),
      ),
    );
  }
}
