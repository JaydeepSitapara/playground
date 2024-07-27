import 'package:flutter/material.dart';
import 'package:playground/network/model/user_model.dart';

class Second extends StatelessWidget {
  final User user;
  const Second({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
    );
  }
}
