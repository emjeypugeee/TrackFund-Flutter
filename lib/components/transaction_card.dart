import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String transacName;
  final String time;
  final String amount;
  final Color? color;
  const TransactionCard({
    super.key,
    required this.transacName,
    required this.time,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 30, child: Icon(Icons.person)),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transacName,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(time, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(amount, style: TextStyle(color: color, fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
