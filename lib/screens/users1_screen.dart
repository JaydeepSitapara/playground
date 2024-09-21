import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/providers/users_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class Users1Screen extends StatefulWidget {
  const Users1Screen({super.key});

  @override
  State<Users1Screen> createState() => _Users1ScreenState();
}

class _Users1ScreenState extends State<Users1Screen> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    log('loading');
    // Fetch more users by increasing the limit
    int newLimit = context.read<UsersProvider>().users.length + 10;

    await context.read<UsersProvider>().getUsersListFromDummy(newLimit);

    if (mounted) {
      setState(() {});
    }

    // Complete the loading process
    refreshController.loadComplete();
  }

  int limit = 10;
  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, usersProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            onLoading: _onLoading,
            onRefresh: _onRefresh,
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final user = snapshot.data?[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(
                              '${user?.firstName ?? ''} ${user?.lastName ?? ''}'),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No users found.'),
                  );
                }
              },
              future: usersProvider.getUsersListFromDummy(limit),
            ),
          ),
        );
      },
    );
  }
}
