import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:track_fund/components/main_pages_widgets/profile_page/profile_header.dart';
import 'package:track_fund/components/main_pages_widgets/profile_page/settings_button.dart';
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/logic/blocs/user/user_bloc.dart';
import 'package:track_fund/model/user_data_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoggingOut) {
            showDialog(
              context: context,
              barrierDismissible: false, 
              builder: (ctx) => const Center(child: CircularProgressIndicator(color: Colors.white)),
            );
          }

          if (state is UserInitial) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            context.go('/login');
          }

          if (state is UserFailure) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserLoginSuccess) {
            return _buildProfileView(context, state.user);
          }

          if (state is UserFailure) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const Center(child: Text("Welcome"));
        },
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, User user) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ProfileHeader(user: UserModel(name: user.username, email: user.email)),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),

        // Bottom Section (Logout)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Divider(),
              SettingsButton(
                icon: Icons.logout,
                iconColor: colorScheme.error,
                name: 'Logout',
                onTap: () {
                  // Trigger the event
                  context.read<UserBloc>().add(LogoutUser());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
