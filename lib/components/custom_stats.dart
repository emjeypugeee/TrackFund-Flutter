import 'package:flutter/material.dart';

class CustomStats extends StatelessWidget {
  final Color? color;
  final Color? iconColor;
  final String name;
  final IconData? icon;

  const CustomStats({super.key, this.color, this.iconColor, required this.name, this.icon});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.4,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name, style: TextStyle(color: Colors.grey, fontSize: 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor),
                Text(' \$8,500', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
