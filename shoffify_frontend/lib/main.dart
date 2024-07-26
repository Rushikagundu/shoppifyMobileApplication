import 'package:flutter/material.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/profile.dart';
import 'package:myntra/men.dart';
import 'package:myntra/order.dart';
import 'package:myntra/product.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:myntra/login.dart';
import 'package:myntra/splash.dart';
import 'package:myntra/women.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ProductProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 181,192,124)),
          useMaterial3: true,
        ),
        home: const splashWidget());
  }
}
