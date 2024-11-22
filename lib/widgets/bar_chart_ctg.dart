import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DiscountBarChart extends StatelessWidget {
  final Map<String, double> discountData;

  const DiscountBarChart({super.key, required this.discountData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: discountData.entries.map((entry) {
          final index = discountData.keys.toList().indexOf(entry.key);
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: entry.value,
                color: Colors.blue,
                width: 10,
              ),
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          rightTitles: AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                if (index < 0 || index >= discountData.keys.length) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(discountData.keys.elementAt(index)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
