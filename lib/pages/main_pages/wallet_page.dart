import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:track_fund/components/main_pages_widgets/wallet_page/add_new_wallet_form.dart';
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/logic/blocs/user/user_bloc.dart';
import 'package:track_fund/logic/blocs/user_wallets/wallet_bloc.dart';
import 'package:track_fund/components/main_pages_widgets/wallet_page/wallet_card.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    super.initState();

    final userState = context.read<UserBloc>().state;
    if (userState is UserLoginSuccess) {
      context.read<WalletBloc>().add(LoadWallets(userState.user.id));
    }
  }

  void _onDeleteWallet(BuildContext context, UserWallet wallet) {
    final walletBloc = this.context.read<WalletBloc>();

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("Delete Wallet"),
            content: Text("Are you sure you want to delete ${wallet.walletName}?"),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
              TextButton(
                onPressed: () {
                  walletBloc.add(DeleteWallet(wallet.id));

                  Navigator.pop(ctx);
                },
                child: const Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  void _onEditWallet(BuildContext context, UserWallet wallet) {
    _showAddNewWalletForm(context, walletToEdit: wallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, userState) {
            if (userState is UserLoginSuccess) {
              context.read<WalletBloc>().add(LoadWallets(userState.user.id));
            }
          },
          child: BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              if (state is WalletLoaded) {
                if (state.wallets.isEmpty) {
                  return Center(child: _buildAddButton(context));
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: state.wallets.length + 1,

                  separatorBuilder: (c, i) => const SizedBox(height: 12),

                  itemBuilder: (context, index) {
                    if (index == state.wallets.length) {
                      return _buildAddButton(context);
                    }

                    final UserWallet wallet = state.wallets[index];
                    bool isBlackCard = index % 2 == 0;

                    return Slidable(
                      key: ValueKey(wallet.id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.5,
                        children: [
                          // DELETE ACTION
                          SlidableAction(
                            onPressed: (context) => _onDeleteWallet(context, wallet),
                            backgroundColor: Colors.grey[700]!,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                          ),
                          // EDIT ACTION
                          SlidableAction(
                            onPressed: (context) => _onEditWallet(context, wallet),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                          ),
                        ],
                      ),
                      child: WalletCard(
                        name: wallet.walletName,
                        balance: wallet.walletBalance.toStringAsFixed(2),
                        holderName: wallet.holderName,
                        lastFourDigit: wallet.lastFourDigit ?? '****',
                        backgroundColor: isBlackCard ? Colors.black : Colors.white,
                        textColor: isBlackCard ? Colors.white : Colors.black,
                      ),
                    );
                  },
                );
              }

              if (state is WalletError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox(); 
            },
          ),
        ),
      ),
    );
  }
}

void _showAddNewWalletForm(BuildContext context, {UserWallet? walletToEdit}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => AddNewWalletForm(walletToEdit: walletToEdit),
  );
}

Widget _buildAddButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      _showAddNewWalletForm(context);
    },
    child: Container(
      height: 180, 
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200], 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[400]!,
          width: 2,
          style: BorderStyle.solid, 
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, size: 40, color: Colors.grey[600]),
          const SizedBox(height: 8),
          Text(
            "Add New Wallet",
            style: TextStyle(color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
