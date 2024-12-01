import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/prodect.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(children: [
            FadeInImage(
              width: 200,
              //fit: BoxFit.cover,
              height: 180,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                product.imageLink,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Colors.black45,
                  child: Text(
                    product.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ))
          ]),
          Text(
            'rate : ${product.rate}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              //  color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Text(
            'category : ${product.cateogry.name}',
            textAlign: TextAlign.center,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              // color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
