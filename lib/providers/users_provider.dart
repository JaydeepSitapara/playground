import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:playground/models/user_model.dart';
import 'package:playground/network/repo.dart';

class UsersProvider extends ChangeNotifier {
  List<User1> users = [];

  Future<List<User1>> getUsersListFromDummy(int limit) async {
    try {
      users = await Repo().getUsersFromDummy(limit);

      return users;
    } catch (e) {
      log('get users error : ${e.toString()}');
      return [];
    }
  }
}
