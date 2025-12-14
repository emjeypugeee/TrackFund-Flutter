import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final String name;
  final String balance;
  final String holderName;
  final String? lastFourDigit;

  // Add these two new properties
  final Color backgroundColor;
  final Color textColor;

  const WalletCard({
    super.key,
    required this.name,
    required this.balance,
    required this.holderName,
    this.lastFourDigit,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // Use the passed color instead of the Gradient
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
        // Optional: Add a subtle border if the card is white so it stands out
        border: backgroundColor == Colors.white ? Border.all(color: Colors.grey.shade300) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TOP SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      color: textColor, // Use dynamic text color
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Current Balance',
                      // Make the label slightly transparent based on the text color
                      style: TextStyle(color: textColor.withValues(alpha: 0.7), fontSize: 14),
                    ),
                    Text(
                      '₱$balance',
                      style: TextStyle(
                        color: textColor, // Use dynamic text color
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // --- BOTTOM SECTION ---
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '**** **** **** $lastFourDigit',
                  style: TextStyle(
                    color: textColor, // Use dynamic text color
                    fontSize: 18,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  holderName,
                  style: TextStyle(
                    color: textColor, // Use dynamic text color
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
