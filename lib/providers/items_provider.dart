import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/models/item_model..dart';

class ItemsProvider extends ChangeNotifier {
  List<Item> items = [];

  void add(Item item) {
    items.add(item);
    notifyListeners();
    log('item added');
  }

  void removeAll() {
    items.clear();
    notifyListeners();
  }

  void remoreAt(index) {
    items.removeAt(index);
    notifyListeners();
  }
}
