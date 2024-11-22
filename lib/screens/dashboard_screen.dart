import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled11/screens/product_scr.dart';

import '../controller/cart_ctrl.dart';
import '../widgets/bar_chart_ctg.dart';
import '../widgets/pie_chart_ctg.dart';
import '../widgets/top_product.dart';
import 'cart_scr.dart';

class DashboardScreen extends StatelessWidget {
  final Map<String, int> categoryData;
  final Map<String, double> discountData;
  final List<Map<String, dynamic>> topProducts;

  DashboardScreen({
    required this.categoryData,
    required this.discountData,
    required this.topProducts,
  });
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), actions: [
        IconButton(
          icon: Icon(Icons.shopping_bag),
          onPressed: () {

            Get.to(()=>ProductScreen());
          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Get.to(() => CartScreen());
          },
        ),
      ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Product Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Get.height/3.5, child: CategoryPieChart(categoryData: categoryData)),
              SizedBox(height:10 ),
                Text(                'Maximum Discounts by Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height:20 ),
              SizedBox(height: Get.height/3, child: DiscountBarChart(discountData: discountData)),
              SizedBox(height: 20),
              Text(
                'Top 5 Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TopProductsTable(topProducts: topProducts),
            ],
          ),
        ),
      ),
    );
  }
}
