import 'package:flutter/material.dart';
import 'package:mobile_app/screens/admin_screens/add_product_screen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddProductScreen();
                }));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(),
    );
  }
}
