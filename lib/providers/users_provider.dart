import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:playground/models/user_model.dart';
import 'package:playground/network/repo.dart';

class UsersProvider extends ChangeNotifier {
  List<User1> users = [];

  Future<List<User1>> getUsersListFromDummy(int limit) async {
    try {
      // Fetch the new set of users from the repository
      List<User1> newUsers = await Repo().getUsersFromDummy(limit);

      // Append the new users to the existing list
      users.addAll(newUsers);



      // Return the updated users list
      return users;
    } catch (e) {
      log('get users error: ${e.toString()}');
      return [];
    }
  }
}


