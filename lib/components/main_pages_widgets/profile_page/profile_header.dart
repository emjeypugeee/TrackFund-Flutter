import 'package:flutter/material.dart';
import 'package:track_fund/model/user_data_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.person, size: 80, color: colors.primary),
        ),
        const SizedBox(height: 16),
        Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(user.email, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
