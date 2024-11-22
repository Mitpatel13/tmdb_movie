import 'package:get/get.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  void addToCart(Product product) {
    cartItems.add(product);
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  bool isInCart(Product product) {
    return cartItems.contains(product);
  }

  void toggleCartStatus(Product product) {
    if (isInCart(product)) {
      removeFromCart(product);
    } else {
      addToCart(product);
    }
  }

  int get totalItems => cartItems.length;
}
