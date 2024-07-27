import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/models/item_model..dart';
import 'package:playground/providers/cart_provider.dart';
import 'package:playground/providers/items_provider.dart';
import 'package:playground/screens/catalog_screen.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (context, item, child) {
        return Scaffold(
          appBar: AppBar(
            
            title: const Text('Add Item'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _idController,
                        decoration: const InputDecoration(
                          hintText: 'id',
                        ),
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name must be provided!';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        log('item add call');
                        item.add(
                          Item(
                            id: _idController.text.trim(),
                            name: _nameController.text.trim().toString(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item added !')));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const CatalogScreen()));
                      }
                    },
                    child: const Text('Add')),
              ],
            ),
          ),
        );
      },
    );
  }
}
