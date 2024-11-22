import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../screens/dashboard_screen.dart';

class SplashController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('https://dummyjson.com/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> productList = List<Map<String, dynamic>>.from(
          jsonDecode(response.body)['products'],
        );
        products.value = productList;
        final categoryData = _getCategoryData(productList);
        final discountData = _getDiscountData(productList);
        final topProducts = _getTopProducts(productList);
        Get.off(() => DashboardScreen(
          categoryData: categoryData,
          discountData: discountData,
          topProducts: topProducts,
        ));
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }

  Map<String, int> _getCategoryData(List<dynamic> products) {
    Map<String, int> data = {};
    for (var product in products) {
      String category = product['category'];
      data[category] = (data[category] ?? 0) + 1;
    }
    return data;
  }

  Map<String, double> _getDiscountData(List<dynamic> products) {
    Map<String, double> data = {};
    for (var product in products) {
      String category = product['category'];
      double discount = product['discountPercentage'];
      if (data.containsKey(category)) {
        if (discount > data[category]!) {
          data[category] = discount;
        }
      } else {
        data[category] = discount;
      }
    }
    return data;
  }

  List<Map<String, dynamic>> _getTopProducts(List<Map<String, dynamic>> products) {
    products.sort((a, b) => b['rating'].compareTo(a['rating']));
    return products.take(5).toList();
  }
}
