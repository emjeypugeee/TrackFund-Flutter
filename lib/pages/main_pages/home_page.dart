import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:track_fund/components/main_pages_widgets/home_page/balance_card.dart';
import 'package:track_fund/components/main_pages_widgets/home_page/transaction_card.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_bloc.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_event.dart'; // IMPORT THIS
import 'package:track_fund/logic/blocs/transaction/transaction_state.dart';
import 'package:track_fund/logic/blocs/user/user_bloc.dart'; // IMPORT THIS
import 'package:track_fund/logic/blocs/user_wallets/wallet_bloc.dart';
import 'package:track_fund/router/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final userState = context.read<UserBloc>().state;
    if (userState is UserLoginSuccess) {
      context.read<TransactionBloc>().add(LoadTransactions(userState.user.id));
      context.read<WalletBloc>().add(LoadWallets(userState.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoginSuccess) {
          context.read<TransactionBloc>().add(LoadTransactions(state.user.id));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //BALANCE CARD
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, walletState) {
                  return BlocBuilder<TransactionBloc, TransactionState>(
                    builder: (context, transState) {
                      String totalBalance = "0.00";
                      String totalIncome = "0.00";
                      String totalExpense = "0.00";

                      // Get Wallet Balance
                      if (walletState is WalletLoaded) {
                        totalBalance = walletState.totalBalance.toStringAsFixed(2);
                      }

                      // Get Income/Expense
                      if (transState is TransactionLoaded) {
                        totalIncome = transState.totalIncome.toStringAsFixed(2);
                        totalExpense = transState.totalExpense.toStringAsFixed(2);
                      }

                      return BalanceCard(
                        totalBalance: '₱$totalBalance',
                        income: '₱$totalIncome',
                        expenses: '₱$totalExpense',
                      );
                    },
                  );
                },
              ),

              SizedBox(height: screenHeight * 0.03),

              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transactions:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => context.push(AppRouter.analytics),
                    child: Text('See All', style: TextStyle(color: Colors.grey[400], fontSize: 15)),
                  ),
                ],
              ),

              // TRANSACTION LIST
              Expanded(
                child: BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is TransactionError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is TransactionLoaded) {
                      if (state.transactions.isEmpty) {
                        return const Center(child: Text("No transactions yet."));
                      }

                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = state.transactions[index];
                          final isExpense = transaction.type.toUpperCase() == 'EXPENSE';

                          return Slidable(
                            key: ValueKey(transaction.id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.25,
                              children: [
                                SlidableAction(
                                  onPressed:
                                      (context) => context.read<TransactionBloc>().add(
                                        DeleteTransaction(transaction.id),
                                      ),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                ),
                              ],
                            ),
                            child: TransactionCard(
                              transacName:
                                  transaction.description.isNotEmpty
                                      ? transaction.description
                                      : transaction.category,
                              time: DateFormat(
                                'MMM dd, h:mm a',
                              ).format(transaction.transactionDate),
                              amount: "₱${transaction.amount.toStringAsFixed(2)}",
                              color: isExpense ? Colors.red : Colors.green,
                              icon:
                                  isExpense
                                      ? Icon(Icons.money_off_csred_outlined)
                                      : Icon(Icons.money_rounded),
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
