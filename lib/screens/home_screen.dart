import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:mobile_app/models/prodect.dart';
import 'package:mobile_app/size_config.dart';
import 'package:mobile_app/widgets/my_input_field.dart';
import 'package:mobile_app/widgets/product_card.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> showenProducts = dummyProducts;
  List<Product> allProducts = [];
  int? selectedCategory;
  bool _isLoaded = true;
  String? _erorr;

  void _getData() async {
    final url = Uri.https(
        'mobile-app-e112c-default-rtdb.firebaseio.com', 'product-list.json');
    try {
      final http.Response res = await http.get(url);
      if (res.statusCode >= 400) {
        setState(() {
          _erorr = 'Faild to fetch data, Please try again later';
        });
        return;
      }
      if (res.body == 'null') {
        setState(() {
          _isLoaded = false;
        });
        return;
      }
      final Map<String, dynamic> loadedData = json.decode(res.body);
      final List<Product> loadedItems = [];
      for (var item in loadedData.entries) {
        final Category category = Category.values.firstWhere(
          (e) => e.name == item.value["category"],
          orElse: () => Category.books,
        );
        loadedItems.add(Product(
          name: item.value['name'],
          id: item.key,
          descreption: item.value['descreption'],
          price: item.value['price'],
          imageLink: item.value['imageLink'],
          numInStock: item.value['numInStock'],
          category: category,
        ));
        setState(() {
          allProducts = loadedItems;
          _isLoaded = false;
        });
      }
    } catch (err) {
      setState(() {
        _erorr = 'Something went wrong.';
        _isLoaded = false;
      });
    }
  }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Widget _content = const Center(
      child: Text('No Items Added Yet'),
    );
    if (_erorr != null) {
      _content = Center(child: Text(_erorr!));
    }
    if (_isLoaded) {
      _content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (allProducts.isNotEmpty) {
      _content = Expanded(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return ProductCard(product: showenProducts[index]);
          },
          itemCount: showenProducts.length,
        ),
      );
    }
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
                          showenProducts = allProducts
                              .where((pro) =>
                                  categortis[index].trim().toLowerCase() ==
                                  pro.category.name)
                              .toList();
                        });
                      } else {
                        setState(() {
                          selectedCategory = index;
                          showenProducts = allProducts;
                        });
                      }
                    },
                    child: Text(
                      categortis[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: selectedCategory == null || selectedCategory == 0
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
          _content
        ],
      ),
    );
  }
}
