import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: colors.primary),
        padding: EdgeInsets.all(15),
        child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16))),
      ),
    );
  }
}
