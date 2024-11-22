import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_ctrl.dart';

class CartScreen extends StatelessWidget {
  final cartController = Get.find<CartController>();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Obx(
                () => Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Total Items'),
                trailing: Text('${cartController.totalItems}'),
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      leading: Image.network(
                        product.images!.isNotEmpty
                            ? product.images?.first ??"https://via.placeholder.com/50"
                            : 'https://via.placeholder.com/50',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          cartController.removeFromCart(product);
                          Get.snackbar('Removed', 'Product removed from cart');
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
