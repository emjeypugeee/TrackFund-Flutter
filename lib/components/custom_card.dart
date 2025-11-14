import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.2,
      width: screenWidth * 1,
      decoration: BoxDecoration(
        color: Color(0xFF408782),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Balance:', style: TextStyle(fontSize: 18, color: Colors.white)),
                Icon(Icons.more_horiz, color: Colors.white),
              ],
            ),

            Text('\$40,000', style: TextStyle(color: Colors.white, fontSize: 25)),

            SizedBox(height: screenHeight * 0.02),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Income:', style: TextStyle(color: Colors.white, fontSize: 18)),
                Text('Expenses:', style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$2,000', style: TextStyle(color: Colors.white, fontSize: 20)),
                Text('\$1,500', style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
