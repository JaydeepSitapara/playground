import 'package:flutter/material.dart';
import 'package:playground/providers/cart_provider.dart';
import 'package:playground/providers/items_provider.dart';
import 'package:playground/screens/catalog_screen.dart';
import 'package:playground/screens/first_screen.dart';
import 'package:playground/screens/slot_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => ItemsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: CatalogScreen(),
    );
  }
}
