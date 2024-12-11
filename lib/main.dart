import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/models/prodect.dart';
import 'package:mobile_app/screens/admin_screens/admin_home.dart';
import 'package:mobile_app/screens/admin_screens/add_product_screen.dart';
import 'package:mobile_app/screens/auth_screen.dart';
import 'package:mobile_app/screens/nav_screen.dart';
import 'package:mobile_app/screens/product_screen.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';

import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
            //  StreamBuilder(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const SplashScreen();
            //     }
            //     if (snapshot.hasData) {
            //       return const NavScreen();
            //     }
            //     return const AuthScreen();
            //   },
            // ),
            const AdminHome());
  }
}
