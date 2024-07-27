import 'package:flutter/material.dart';
import 'package:playground/models/item_model..dart';
import 'package:playground/providers/cart_provider.dart';
import 'package:playground/screens/add_item_screen.dart';
import 'package:provider/provider.dart';

import '../providers/items_provider.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ItemsProvider, CartProvider>(
      builder: (context, item, cart, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Catalog'),
          ),
          body: item.items.isEmpty
              ? const Center(
                  child: Text('No item found please add some! '),
                )
              : ListView.builder(
                  itemCount: item.items.length,
                  itemBuilder: (context, index) {
                    final items = item.items[index];
                    return ListTile(
                      title: Text(items.name.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          cart.add(
                            Item(id: items.id, name: items.name),
                            context,
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddItemScreen(),
                ),
              );
            },
            child: Center(child: Icon(Icons.add)),
          ),
        );
      },
    );
  }
}
