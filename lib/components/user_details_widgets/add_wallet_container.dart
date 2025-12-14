import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/components/user_details_widgets/add_wallet_form.dart';
import 'package:track_fund/logic/blocs/sign_up/sign_up_cubit.dart';

class AddWalletContainer extends StatelessWidget {
  const AddWalletContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [colorScheme.primary, colorScheme.tertiary],
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          // 1. Trigger the input sheet on tap
          onTap: () => _showAddWalletSheet(context),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                _WalletHeader(textTheme: textTheme),
                const Divider(color: Colors.white24),
                // 2. Updated visual cue to imply interactivity
                _ActionRow(
                  icon: Icons.add_circle_outline,
                  label: 'Add New Wallet',
                  textTheme: textTheme,
                ),
                const SizedBox(height: 4),
                BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return _BalanceRow(
                      label: 'Total Income:',
                      amount: '₱${state.totalIncome}',
                      textTheme: textTheme,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddWalletSheet(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return BlocProvider.value(value: signUpCubit, child: const AddWalletForm());
      },
    );
  }
}

class _WalletHeader extends StatelessWidget {
  final TextTheme textTheme;
  const _WalletHeader({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My Wallets', // Slightly changed text to fit context
          style: textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.wallet, color: Colors.white, size: 32),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextTheme textTheme;

  const _ActionRow({required this.icon, required this.label, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(icon, color: Colors.white, size: 28),
        Text(label, style: textTheme.bodyMedium?.copyWith(color: Colors.white)),
      ],
    );
  }
}

class _BalanceRow extends StatelessWidget {
  final String label;
  final String amount;
  final TextTheme textTheme;

  const _BalanceRow({required this.label, required this.amount, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 8,
          children: [
            const Icon(Icons.monetization_on_outlined, color: Colors.white, size: 28),
            Text(
              label,
              style: textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
