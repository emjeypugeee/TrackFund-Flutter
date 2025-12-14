import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track_fund/components/main_pages_widgets/home_page/transaction_card.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_bloc.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_state.dart';

enum TabType { income, expenses }

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _TabBarState();
}

class _TabBarState extends State<CustomTabBar> {
  TabType selectedTab = TabType.expenses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              // INCOME TAB
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = TabType.income;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedTab == TabType.income ? Colors.black : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Income',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedTab == TabType.income ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // EXPENSES TAB
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = TabType.expenses;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedTab == TabType.expenses ? Colors.black : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Expenses',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedTab == TabType.expenses ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // FILTERED LIST
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TransactionLoaded) {
              final filteredList =
                  state.transactions.where((t) {
                    if (selectedTab == TabType.expenses) {
                      return t.type.toUpperCase() == 'EXPENSE';
                    } else {
                      return t.type.toUpperCase() == 'INCOME';
                    }
                  }).toList();

              if (filteredList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    "No ${selectedTab == TabType.income ? 'Income' : 'Expenses'} yet.",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                );
              }

              // LIST
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                separatorBuilder: (c, i) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final transaction = filteredList[index];
                  final isExpense = transaction.type.toUpperCase() == 'EXPENSE';

                  return TransactionCard(
                    transacName:
                        transaction.description.isNotEmpty
                            ? transaction.description
                            : transaction.category,
                    time: DateFormat('MMM dd, h:mm a').format(transaction.transactionDate),
                    amount: "₱${transaction.amount.toStringAsFixed(2)}",
                    color: isExpense ? Colors.red : Colors.green,
                    icon:
                        isExpense
                            ? Icon(Icons.money_off_csred_outlined)
                            : Icon(Icons.money_rounded),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
