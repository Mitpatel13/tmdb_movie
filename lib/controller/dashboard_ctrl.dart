import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled11/controller/splash_ctrl.dart';

class DashboardController extends GetxController {
  final products = Get.find<SplashController>().products;

  Map<String, List<dynamic>> get productCategories {
    return groupBy(products, (product) => product['category'] as String);
  }
  Map<String, int> get productCategoryCounts {
    return productCategories.map((key, value) => MapEntry(key, value.length));
  }
  Map<String, double> get productCategoryData {
    Map<String, double> data = {};
    for (var product in products) {
      String category = product['category'];
      if (data.containsKey(category)) {
        data[category] = data[category]! + 1;
      } else {
        data[category] = 1;
      }
    }
    return data;
  }

  List<BarChartGroupData> get discountData {
    Map<String, double> maxDiscounts = {};
    for (var product in products) {
      String category = product['category'];
      double discount = product['discountPercentage'];
      if (maxDiscounts.containsKey(category)) {
        if (discount > maxDiscounts[category]!) {
          maxDiscounts[category] = discount;
        }
      } else {
        maxDiscounts[category] = discount;
      }
    }
    List<BarChartGroupData> barGroups = [];
    int index = 0;
    maxDiscounts.forEach((category, discount) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: discount,
              color: Colors.blue,
              width: 20,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
      index++;
    });
    return barGroups;
  }
}