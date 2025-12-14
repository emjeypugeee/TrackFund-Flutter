import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/logic/blocs/themes/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        final isDark = state == ThemeMode.dark;
        return IconButton(
          onPressed: context.read<ThemeCubit>().toggleTheme,
          icon: Icon(isDark ? Icons.sunny : Icons.dark_mode),
        );
      },
    );
  }
}
