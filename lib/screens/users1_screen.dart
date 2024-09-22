import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/models/user_model.dart';
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
  ScrollController scrollController = ScrollController();

  Future<List<User1>>? userFuture;

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void fetchData() {
    // Fetch more users by increasing the limit
    int newLimit = context.read<UsersProvider>().users.length + 10;

    userFuture = context.read<UsersProvider>().getUsersListFromDummy(newLimit);
  }

  void _onLoading() async {
    log('loading');

    fetchData();

    // Complete the loading process
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, usersProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
          ),
          body: FutureBuilder(
              future: userFuture,
              builder: (context, snapshot) {
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: refreshController,
                  onLoading: _onLoading,
                  onRefresh: _onRefresh,
                  scrollController: scrollController,
                  child: ListView.builder(
                    itemCount: usersProvider.users.length,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final user = usersProvider.users[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(
                              '${user?.firstName ?? ''} ${user?.lastName ?? ''}'),
                        ),
                      );
                    },
                  ),
                );
              }),
        );
      },
    );
  }
}
