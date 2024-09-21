import 'package:flutter/material.dart';
import 'package:playground/providers/products_provider.dart';
import 'package:provider/provider.dart';

class FavouriteProductsScreen extends StatefulWidget {
  const FavouriteProductsScreen({super.key});

  @override
  State<FavouriteProductsScreen> createState() {
    return _FavouriteProductsScreenState();
  }
}

class _FavouriteProductsScreenState extends State<FavouriteProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, product, child) {
          return product.favorites.isEmpty
              ? const Center(
                  child: Text('No faourite avaiable'),
                )
              : ListView.builder(
                  itemCount: product.favorites.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        product.favorites[index].toString(),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            if (product.products.contains(index)) {
                              product.removeFavorite(index);
                            }
                          },
                          icon: Icon(
                            product.favorites.contains(index+1)
                                ? Icons.favorite
                                : Icons.favorite_border,
                          )),
                    );
                  },
                );
        },
      ),
    );
  }
}
