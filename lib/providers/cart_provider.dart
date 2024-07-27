import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/models/item_model..dart';
import 'package:playground/screens/cart_screen.dart';

class CartProvider extends ChangeNotifier {
  List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int? get totalPrice => _items.length * 10;

  void add(Item item, BuildContext context) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
    log('item added to cart');
  }

  void remove(index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
