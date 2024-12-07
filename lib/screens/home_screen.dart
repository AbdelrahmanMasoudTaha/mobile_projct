import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:mobile_app/models/prodect.dart';
import 'package:mobile_app/size_config.dart';
import 'package:mobile_app/widgets/my_input_field.dart';
import 'package:mobile_app/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> showenProducts = dummyProducts;
  int? selectedCategory;
  final List<String> categortis = [
    'All',
    'electronics',
    'clothes',
    'furniture',
    'books',
    'toys',
    'sports'
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shoping Home'),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const MyInputField(
              hint: "Search",
              widget: Icon(
                Icons.search,
                size: 30,
                color: Colors.black54,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: SizeConfig.screenWidth,
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        if (index != 0) {
                          setState(() {
                            selectedCategory = index;
                            showenProducts = dummyProducts
                                .where((pro) =>
                                    categortis[index].trim().toLowerCase() ==
                                    pro.cateogry.name)
                                .toList();
                          });
                        } else {
                          setState(() {
                            selectedCategory = index;
                            showenProducts = dummyProducts;
                          });
                        }
                      },
                      child: Text(
                        categortis[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color:
                              selectedCategory == null || selectedCategory == 0
                                  ? Theme.of(context).colorScheme.primary
                                  : selectedCategory == index
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: categortis.length,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return ProductCard(product: showenProducts[index]);
                },
                itemCount: showenProducts.length,
              ),
            )
          ],
        ));
  }
}
