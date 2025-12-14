import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/components/main_pages_widgets/analytics_page/custom_line_chart.dart';
import 'package:track_fund/components/main_pages_widgets/analytics_page/custom_stats.dart';
import 'package:track_fund/components/main_pages_widgets/analytics_page/custom_tab_bar.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_bloc.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_state.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, transState) {
                  String totalIncome = "0.00";
                  String totalExpense = "0.00";

                  if (transState is TransactionLoaded) {
                    totalIncome = transState.totalIncome.toStringAsFixed(2);
                    totalExpense = transState.totalExpense.toStringAsFixed(2);
                  }

                  // Stats
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomStats(
                        icon: Icons.arrow_circle_down_rounded,
                        color: colors.surface,
                        name: 'Total Income',
                        amount: totalIncome,
                        textColor: Colors.greenAccent[400],
                      ),
                      CustomStats(
                        icon: Icons.arrow_circle_up_rounded,
                        color: colors.surface,
                        name: 'Total Expenses',
                        amount: totalExpense,
                        textColor: Colors.redAccent[400],
                      ),
                    ],
                  );
                },
              ),

              // HEADER
              SizedBox(height: screenHeight * 0.03),
              const Text('Statistics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

              SizedBox(height: screenHeight * 0.03),

              SizedBox(height: screenHeight * 0.3, child: const MyGroupedBarChart()),

              SizedBox(height: screenHeight * 0.03),

              // SHOWS EXPENSE AND INCOME
              const CustomTabBar(),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
