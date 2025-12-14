import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/logic/blocs/sign_up/sign_up_cubit.dart';

class WalletList extends StatelessWidget {
  const WalletList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final wallets = state.tempWallets;

        if (wallets.isEmpty) {
          // Improved Empty State
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("No wallets added yet.", style: TextStyle(color: Colors.white70)),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: wallets.length,
          separatorBuilder: (c, i) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final wallet = wallets[index];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  child: Icon(Icons.account_balance_wallet, color: colors.primary),
                ),
                // 1. Show Wallet Name
                title: Text(wallet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                // 2. Show Holder Name & Card Digits
                subtitle: Text(
                  "${wallet.holderName} • **** ${wallet.lastFourDigit}",
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "₱${wallet.balance.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => context.read<SignUpCubit>().removeTempWallet(index),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
