import 'package:flutter/material.dart';
import 'package:playground/network/model/user_model.dart';
import 'package:playground/network/repo.dart';
import 'package:playground/screens/second_screen.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: FutureBuilder<List<User>>(
        future: Repo().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final user = snapshot.data?[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Second(user: user!),
                      ),
                    );
                  },
                  title: Text(user?.name ?? ''),
                  subtitle: Text(user?.email ?? ''),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
