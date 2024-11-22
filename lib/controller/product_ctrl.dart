import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var searchQuery = ''.obs;
  var isDarkTheme = false.obs;
  var expandedCardIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    final url = Uri.parse('https://dummyjson.com/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var productList = (jsonData['products'] as List)
            .map((product) => Product.fromJson(product))
            .toList();
        products.value = productList;
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e,t) {
      print('Trace ERROR$t');
      Get.snackbar('Error', 'An error occurred');
    }
  }

  List<Product> get filteredProducts {
    if (searchQuery.value.isEmpty) {
      return products;
    } else {
      return products
          .where((product) => product.title
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }


}
