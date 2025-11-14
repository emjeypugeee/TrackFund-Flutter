import 'package:flutter/material.dart';
import 'package:track_fund/components/custom_stats.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Overview', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomStats(
                  color: Colors.purple[50],
                  icon: Icons.arrow_circle_down_rounded,
                  iconColor: Colors.deepPurpleAccent,
                  name: 'Total Income',
                ),
                CustomStats(
                  color: Colors.orange[50],
                  icon: Icons.arrow_circle_up_rounded,
                  iconColor: Colors.orange,
                  name: 'Total Expenses',
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),
            Text('Statistics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
