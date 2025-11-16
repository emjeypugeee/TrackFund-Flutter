import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: CircleAvatar(radius: 60, child: Icon(Icons.person, size: 50))),
            SizedBox(height: screenHeight * 0.02),
            Text('Amir Perez', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('amirperez@gmail.com', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
