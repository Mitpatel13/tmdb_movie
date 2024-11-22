import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryPieChart extends StatelessWidget {
  final Map<String, int> categoryData;

  const CategoryPieChart({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: categoryData.entries.map((entry) {
          final color = Colors.primaries[
          categoryData.keys.toList().indexOf(entry.key) %
              Colors.primaries.length];
          return PieChartSectionData(
            value: entry.value.toDouble(),
            title: entry.key,
            color: color,
            radius: 50,
            titleStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
        centerSpaceRadius: 40,
        sectionsSpace: 2,
      ),
    );
  }
}
