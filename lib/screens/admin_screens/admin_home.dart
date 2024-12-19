import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/screens/admin_screens/add_product_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/screens/admin_screens/all_products_screen.dart';
import 'package:mobile_app/widgets/admin_product_card.dart';
import 'package:mobile_app/widgets/chart.dart';

import '../../models/prodect.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<Product> allProducts = [];
  List<Product> top5Products = [];
  int? selectedCategory;
  bool _isLoaded = true;
  int maxSold = 0;
  List<Color> colors = [
    Color.fromARGB(255, 36, 179, 84),
    Color.fromARGB(255, 15, 143, 148),
    Color.fromARGB(255, 29, 112, 180),
    Color.fromARGB(255, 77, 55, 202),
    Color.fromARGB(255, 154, 53, 185),
  ];
  String? _erorr;
  final url = Uri.https(
      'mobile-app-e112c-default-rtdb.firebaseio.com', 'product-list.json');
  void _getData() async {
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
        loadedItems.add(
          Product(
            soldTimes: item.value['soldTimes'],
            name: item.value['name'],
            id: item.key,
            descreption: item.value['descreption'],
            price: item.value['price'],
            imageLink: item.value['imageLink'],
            numInStock: item.value['numInStock'],
            category: category,
            rate: double.tryParse(item.value['rate'].toString()) ?? 0.0,
          ),
        );
        setState(() {
          allProducts = loadedItems;

          _isLoaded = false;
        });
      }
    } catch (err) {
      setState(() {
        log(err.toString());
        _erorr = 'Something went wrong.';
        _isLoaded = false;
      });
    }
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        log('Product deleted successfully');
      } else {
        log('Failed to delete product: ${response.statusCode}');
        log('Error: ${response.body}');
      }
    } catch (error) {
      log('An error occurred: $error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget _content = Center(
      child: Text(
        'No Items Added Yet',
        style: GoogleFonts.alef(
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    );
    if (_erorr != null) {
      _content = Center(
          child: Text(
        _erorr!,
        style: GoogleFonts.alef(
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ));
    }
    if (_isLoaded) {
      _content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (allProducts.isNotEmpty) {
      allProducts.sort((a, b) => b.soldTimes.compareTo(a.soldTimes));
      top5Products = allProducts.take(5).toList();
      maxSold = top5Products[0].soldTimes;
      List<int> topTimes = [];
      for (Product p in top5Products) {
        topTimes.add(p.soldTimes);
      }

      _content = Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Best Sellers',
              style: GoogleFonts.alef(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                //color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Chart(topSoldTimes: topTimes, colors: colors),
            const SizedBox(
              height: 7,
            ),
            for (Product pro in top5Products)
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors[top5Products.indexOf(pro)]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pro.name,
                      style: GoogleFonts.alef(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Sold Times : ${pro.soldTimes}',
                      style: GoogleFonts.alef(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AllProductsScreen(allProducts: allProducts);
                  }));
                },
                child: Text(
                  'Go To All Products ',
                  style: GoogleFonts.alef(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ))
          ],
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddProductScreen();
                }));
              },
              icon: const Icon(Icons.add)),
          title: Text(
            'Admin Home',
            style: GoogleFonts.alef(
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                //log(FirebaseAuth.instance.currentUser!.uid);
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddProductScreen();
                }));
              },
              icon: Icon(
                Icons.add_business_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _getData();
                });
              },
              icon: Icon(
                Icons.replay,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        body: _content);
  }
}
