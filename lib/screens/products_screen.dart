import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/providers/products_provider.dart';
import 'package:playground/screens/favourite_products_screen.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ProductsScreenState();
  }
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    log('build');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavouriteProductsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.favorite))
        ],
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, product, child) {
          return FutureBuilder(
            future: product.getProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length ?? 0,
                  itemBuilder: (context, index) {
                    final products = snapshot.data![index];
                    return ListTile(
                      title: Text(products.title ?? ''),
                      trailing: IconButton(
                        onPressed: () {
                          if (product.favorites.contains(index)) {
                            product.removeFavorite(index);
                          } else {
                            product.addFavorite(index);
                          }
                        },
                        icon: product.favorites.contains(index)
                            ? const Icon(
                                Icons.favorite,
                              )
                            : const Icon(
                                Icons.favorite_border,
                              ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
