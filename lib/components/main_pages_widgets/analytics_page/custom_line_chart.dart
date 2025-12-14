import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_bloc.dart';
import 'package:track_fund/logic/blocs/transaction/transaction_state.dart';

class MyGroupedBarChart extends StatefulWidget {
  const MyGroupedBarChart({super.key});

  @override
  State<MyGroupedBarChart> createState() => _MyGroupedBarChartState();
}

class _MyGroupedBarChartState extends State<MyGroupedBarChart> {
  final Color darkBar = Colors.grey[800]!;
  final Color lightBar = Colors.grey[400]!;
  final double width = 12;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        List<Map<String, double>> weeklyData = List.generate(
          4,
          (_) => {'income': 0.0, 'expense': 0.0},
        );

        if (state is TransactionLoaded) {
          weeklyData = state.weeklyChartData;
        }

        return BarChart(
          BarChartData(
            maxY: _calculateMaxY(weeklyData),
            minY: 0,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1000,
              getDrawingHorizontalLine:
                  (value) => const FlLine(color: Colors.grey, strokeWidth: 0.5, dashArray: [5, 5]),
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: getBottomTitles,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 1000,
                  getTitlesWidget: getLeftTitles,
                ),
              ),
            ),

            // Map the data to the bars
            barGroups: List.generate(4, (index) {
              // Safety check to ensure we don't crash if map keys are missing
              final income = weeklyData[index]['income'] ?? 0.0;
              final expense = weeklyData[index]['expense'] ?? 0.0;
              return makeGroupData(index, income, expense);
            }),
          ),
        );
      },
    );
  }

  // VISUAL HELPERS 

  // Calculates the top of the chart (Y-axis ceiling)
  double _calculateMaxY(List<Map<String, double>> data) {
    double highest = 0;
    for (var week in data) {
      if ((week['income'] ?? 0) > highest) highest = week['income']!;
      if ((week['expense'] ?? 0) > highest) highest = week['expense']!;
    }
    return (highest < 4000) ? 4000 : ((highest / 1000).ceil() * 1000).toDouble();
  }

  // Bar chart design
  BarChartGroupData makeGroupData(int x, double income, double expense) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: income,
          color: darkBar,
          width: width,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(show: false),
        ),
        BarChartRodData(
          toY: expense,
          color: lightBar,
          width: width,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(show: false),
        ),
      ],
      barsSpace: 4,
    );
  }

  // Bottom titles 
  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '3w ago';
        break;
      case 1:
        text = '2w ago';
        break;
      case 2:
        text = 'Last Wk';
        break;
      case 3:
        text = 'This Wk';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(meta: meta, space: 10, child: Text(text, style: style));
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.grey);
    String text;
    if (value >= 1000) {
      text = '₱${(value / 1000).toStringAsFixed(0)}k';
    } else {
      text = '₱${value.toInt()}';
    }
    return SideTitleWidget(meta: meta, space: 5, child: Text(text, style: style));
  }
}
