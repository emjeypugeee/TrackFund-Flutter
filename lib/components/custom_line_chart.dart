import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyGroupedBarChart extends StatefulWidget {
  const MyGroupedBarChart({super.key});

  @override
  State<MyGroupedBarChart> createState() => _MyGroupedBarChartState();
}

class _MyGroupedBarChartState extends State<MyGroupedBarChart> {
  // Define the colors from the image
  final Color purpleBar = Colors.purple;
  final Color orangeBar = Colors.orange;
  final double width = 18; // Width of each bar

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        // Set the maximum Y-value (from your chart)
        maxY: 4000,
        minY: 0,

        // Hide the default border
        borderData: FlBorderData(show: false),

        // Configure the grid lines
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false, // Hide vertical lines
          horizontalInterval: 1000, // Interval of $1k
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Colors.grey,
              strokeWidth: 0.8,
              dashArray: [5, 5], // Create dashed lines
            );
          },
        ),

        // Define the axis titles (labels)
        titlesData: FlTitlesData(
          show: true,
          // Top titles (hidden)
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // Right titles (hidden)
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // Bottom titles (Week 1, Week 2, etc.)
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: getBottomTitles,
            ),
          ),
          // Left titles ($0, $1k, $2k, etc.)
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 1000,
              getTitlesWidget: getLeftTitles,
            ),
          ),
        ),

        // Define the bar groups
        barGroups: [
          // Group for Week 1
          makeGroupData(0, 2600, 1500),
          // Group for Week 2
          makeGroupData(1, 1250, 900),
          // Group for Week 3
          makeGroupData(2, 1800, 1250),
          // Group for Week 4
          makeGroupData(3, 2050, 1150),
        ],
      ),
    );
  }

  // Helper function to create each group's data
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x, // The x-axis coordinate (0 for Week 1, 1 for Week 2, etc.)
      barRods: [
        // The purple bar
        BarChartRodData(
          toY: y1,
          color: purpleBar,
          width: width,
          borderRadius: BorderRadius.circular(4),
        ),
        // The orange bar
        BarChartRodData(
          toY: y2,
          color: orangeBar,
          width: width,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
      // Space between the two bars in a group
      barsSpace: 4,
    );
  }

  // Helper function for bottom axis labels
  // Helper function for bottom axis labels
  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Week 1';
        break;
      case 1:
        text = 'Week 2';
        break;
      case 2:
        text = 'Week 3';
        break;
      case 3:
        text = 'Week 4';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      // axisSide: meta.axisSide, // <-- REMOVE THIS LINE
      space: 10,
      meta: meta,
      child: Text(text, style: style),
    );
  }

  // Helper function for left axis labels
  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14);
    String text;
    if (value == 0) {
      text = '\$0';
    } else if (value == 1000) {
      text = '\$1k';
    } else if (value == 2000) {
      text = '\$2k';
    } else if (value == 3000) {
      text = '\$3k';
    } else if (value == 4000) {
      text = '\$4k';
    } else {
      return Container();
    }
    return SideTitleWidget(
      // axisSide: meta.axisSide, // <-- REMOVE THIS LINE
      space: 5,
      meta: meta,
      child: Text(text, style: style),
    );
  }
}
