import 'package:flutter/material.dart';

import '../models/prodect.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            product.imageLink,
            width: 200,
            height: 150,
          ),
          Text(product.name),
          Text('rate : ${product.rate}')
        ],
      ),
    );
  }
}
