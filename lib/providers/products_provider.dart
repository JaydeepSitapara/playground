import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/models/products_model.dart';
import 'package:dio/dio.dart';

class ProductsProvider extends ChangeNotifier {
  final dio = Dio();

  List<Products> products = [];

  List<int> favorites = [];

  Future<List<Products>> getProducts() async {
    
    try {
      final response = await dio.get('https://dummyjson.com/products');

      products = Products.listFromJson(response.data['products']);

      if (response.statusCode == 200) {
        // log('Products length : ${products.length}');
      } else {
        log('response status code : ${response.statusCode}');
      }

      return products;
    } catch (e) {
      log('error in get Products: ${e.toString()}');
    }
    return [];
  }

  void addFavorite(int index) {
    favorites.add(index);
    notifyListeners();
    log('added to favorite  $index');
    log(favorites.toString());
  }

  void removeFavorite(int index) {
    favorites.remove(index);
    notifyListeners();
    log('removed to favorite $index');
  }
}
