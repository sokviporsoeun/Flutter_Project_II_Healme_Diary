import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppLineChart extends StatelessWidget {
  final List<FlSpot> points;
  final Color barColor;
  final String title;

  const AppLineChart({
    super.key,
    required this.points,
    required this.barColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
              lineBarsData: [
                LineChartBarData(
                  spots: points,
                  isCurved: true,
                  color: barColor,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: true, color: barColor.withOpacity(0.2)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}