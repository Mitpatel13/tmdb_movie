import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_ctrl.dart';
import '../controller/product_ctrl.dart';
import '../controller/theme_ctrl.dart';
import 'cart_scr.dart';

class ProductScreen extends StatelessWidget {
  final productController = Get.put(ProductController());
  final cartController = Get.find<CartController>();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),

          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                productController.searchQuery.value = value;
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: productController.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = productController.filteredProducts[index];
                  return Obx(
                        () {
                      bool inCart = cartController.isInCart(product);
                      return ExpansionTile(
                        key: Key(product.id.toString()),
                        initiallyExpanded:
                        productController.expandedCardIndex.value == index,
                        onExpansionChanged: (expanded) {
                          if (expanded) {
                            productController.expandedCardIndex.value = index;
                          } else if (productController
                              .expandedCardIndex.value ==
                              index) {
                            productController.expandedCardIndex.value = -1;
                          }
                        },
                        leading: Stack(
                          children: [
                            Image.network(
                              product.images!.isNotEmpty
                                  ? product.images?.first ??"https://via.placeholder.com/50"
                                  : 'https://via.placeholder.com/50',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            if (product.availabilityStatus == 'Out of Stock')
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black54,
                                  child: Center(
                                    child: Text(
                                      'Out of Stock',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Text(product.title),
                        subtitle:
                        Text('${product.category} - \$${product.price}'),
                        children: [
                          ListTile(
                            title: Text('Brand: ${product.brand}'),
                            subtitle: Text(product.description),
                          ),
                          ListTile(
                            title: Text(
                                'Warranty: ${product.warrantyInformation}'),
                          ),
                          ListTile(
                            title: Text('Reviews:'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: product.reviews!
                                  .map((review) => Text(
                                  '${review.reviewerName}: ${review.comment} (${review.rating}/5)'))
                                  .toList() ??[],
                            ),
                          ),
                          Obx(() {
                            bool inCart = cartController.isInCart(product);
                            return ElevatedButton(
                              onPressed: () {
                                cartController.toggleCartStatus(product);
                                Get.snackbar(
                                  inCart ? 'Removed' : 'Added',
                                  inCart ? 'Product removed from cart' : 'Product added to cart',
                                );
                              },
                              child: Text(inCart ? 'Remove from Cart' : 'Add to Cart'),
                            );
                          })

                        ],
                      );
                    },
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
