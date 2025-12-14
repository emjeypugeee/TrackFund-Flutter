import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String name;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap; // Use VoidCallback for readability

  const SettingsButton({super.key, required this.name, this.icon, this.iconColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    // ListTile handles the layout automatically
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Icon(icon, color: iconColor, size: 30),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
