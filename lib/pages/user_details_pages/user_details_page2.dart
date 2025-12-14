import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:track_fund/components/custom_button.dart';
import 'package:track_fund/components/custom_textfield.dart';
import 'package:track_fund/logic/blocs/sign_up/sign_up_cubit.dart';
import 'package:track_fund/logic/blocs/user/user_bloc.dart';
import 'package:track_fund/router/app_router.dart';

class UserDetailsPage2 extends StatefulWidget {
  const UserDetailsPage2({super.key});

  @override
  State<UserDetailsPage2> createState() => _UserDetailsPage2State();
}

class _UserDetailsPage2State extends State<UserDetailsPage2> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _contactController;
  late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _contactController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // 1. Create User & Wallets
        await context.read<SignUpCubit>().submitSignUp(
          username: _usernameController.text,
          password: _passwordController.text,
          email: _emailController.text,
          contact: _contactController.text,
        );

        if (mounted) {
          Navigator.of(context).pop();
          context.read<UserBloc>().add(
            LoginUser(username: _usernameController.text, password: _passwordController.text),
          );

          await Future.delayed(const Duration(milliseconds: 400));

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            context.go(AppRouter.home);
          }
        }
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(20.0), // increased padding for cleaner look
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Pushes button to bottom
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Username'),
                          CustomTextfield(
                            hintText: 'Nickname or Username',
                            icon: Icons.person,
                            controller: _usernameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              }
                              if (value.length < 6) {
                                return 'Username must be at least 8 characters';
                              }
                              return null;
                            },
                            inputFormatters: [LengthLimitingTextInputFormatter(50)],
                          ),
                          const SizedBox(height: 20),

                          _buildLabel('Email'),
                          CustomTextfield(
                            hintText: 'Email',
                            icon: Icons.email,
                            controller: _emailController,
                            validator: (value) {
                              final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(value!);

                              if (!emailValid) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: [LengthLimitingTextInputFormatter(50)],
                          ),
                          const SizedBox(height: 20),

                          _buildLabel('Contact Number'),
                          CustomTextfield(
                            hintText: '09xxxxxxxxx',
                            icon: Icons.phone,
                            controller: _contactController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your contact number';
                              }
                              if (value.length < 6) {
                                return 'Contact must be 11 digits';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                          ),
                          const SizedBox(height: 20),

                          _buildLabel('Password'),
                          CustomTextfield(
                            hintText: 'Password',
                            icon: Icons.lock,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            inputFormatters: [],
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(text: 'Get Started!', onTap: _submitForm),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}
