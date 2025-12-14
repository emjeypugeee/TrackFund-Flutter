import 'package:flutter/material.dart';

class UserWalletButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap; // The function to call when clicked
  final bool isSelected; // Is this button currently active?

  const UserWalletButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // Change background color if selected
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? colors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              // Change icon color if selected
              color: isSelected ? colors.primary : Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                // Change text color if selected
                color: isSelected ? colors.primary : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
