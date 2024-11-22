import 'package:flutter/material.dart';

class TopProductsTable extends StatelessWidget {
  final List<Map<String, dynamic>> topProducts;

  TopProductsTable({required this.topProducts});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Image')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Warranty')),
      ],
      rows: topProducts.map((product) {
        final price = product['price'];
        final discount = product['discountPercentage'];
        final discountedPrice = price - (price * discount / 100);
        final availability = product['availabilityStatus'];
        return DataRow(cells: [
          DataCell(
            Stack(
              children: [
                Image.network(
                  product['thumbnail'],
                  width: 50,
                  height: 50,
                ),
                if (availability == 'Out of Stock')
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: Center(
                        child: Text(
                          'Out of Stock',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          DataCell(Text(product['title'])),
          DataCell(Text(
              '\$$price (\$${discountedPrice.toStringAsFixed(2)} after discount)',maxLines:3 ,softWrap: true,)),
          DataCell(Text(product['warrantyInformation'])),
        ]);
      }).toList(),
    );
  }
}
