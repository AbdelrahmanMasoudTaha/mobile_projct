import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/models/prodect.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: cartProducts.isEmpty
          ? const Center(
              child: Text('Your cart is empty'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: cartProducts.entries.map((entry) {
                      final product = entry.key;
                      final quantity = entry.value;

                      return ListTile(
                        leading: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // image: NetworkImage(widget.product.imageLink)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product.imageLink,
                              fit: BoxFit.fill,
                              height: 40,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        title: Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text('Quantity: $quantity'),
                            const SizedBox(
                              width: 12,
                            ),
                            Text('Price of one: ${product.price} \$'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            final TextEditingController quantityController =
                                TextEditingController(
                                    text: quantity.toString());

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      Text('Set Quantity for ${product.name}'),
                                  content: TextField(
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Enter Quantity',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final inputQuantity = int.tryParse(
                                            quantityController.text);

                                        if (inputQuantity != null &&
                                            inputQuantity >= 0) {
                                          if (product.numInStock <
                                              inputQuantity) {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text(
                                                    'NO Enough Products'),
                                                content: Text(
                                                    'We hove not a $inputQuantity of the product"${product.name}" .'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            ref
                                                .read(cartProvider.notifier)
                                                .setProductQuantity(
                                                    product, inputQuantity);
                                            Navigator.of(context).pop();
                                          }
                                        }
                                      },
                                      child: const Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final double totalCoat =
                        ref.read(cartProvider.notifier).totalCost();
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Purchase Details'),
                        content: Text(
                            'You bought all product in the cart with a prixe of "$totalCoat \$" .'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              cartProducts.forEach((pro, times) {
                                userBuying(pro, times);
                              });
                              ref
                                  .read(cartProvider.notifier)
                                  .removeAllProducts();

                              Navigator.of(ctx).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Buy All Now'),
                ),
              ],
            ),
    );
  }

  void userBuying(Product product, int numToBuy) async {
    final url = Uri.https('mobile-app-e112c-default-rtdb.firebaseio.com',
        '/product-list/${product.id}.json');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'numInStock': product.numInStock - numToBuy,
          'soldTimes': product.soldTimes + numToBuy
        }),
      );

      if (response.statusCode == 200) {
        log("Product updated successfully!");
      } else {
        log("Failed to update product: ${response.statusCode}");
      }
    } catch (error) {
      log("Error updating product: $error");
    }
  }
}
