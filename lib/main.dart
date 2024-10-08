import 'package:flutter/material.dart';
import 'package:playground/backgroud_test/background_services/background_service_provider.dart';
import 'package:playground/backgroud_test/ui/home_screen_backgroud.dart';
import 'package:playground/providers/cart_provider.dart';
import 'package:playground/providers/items_provider.dart';
import 'package:playground/providers/products_provider.dart';
import 'package:playground/providers/users_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ItemsProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreenBackgroud(),
    );
  }
}
