import 'package:flutter/material.dart';
import 'package:playground/providers/users_provider.dart';
import 'package:provider/provider.dart';

class Users1Screen extends StatefulWidget {
  const Users1Screen({super.key});

  @override
  State<Users1Screen> createState() => _Users1ScreenState();
}

class _Users1ScreenState extends State<Users1Screen> {
   ScrollController scrollController = ScrollController();
  int limit = 10;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Check if the user has scrolled to the bottom
    if (scrollController?.position.extentAfter == 0 && !isLoadingMore) {
      setState(() {
        isLoadingMore = true; // Prevent multiple fetches
        limit += 10;
      });

      
      context.read<UsersProvider>().getUsersListFromDummy(limit).then((_) {
        setState(() {
          isLoadingMore = false; 
        });
      });
    }
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
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && !isLoadingMore) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final user = snapshot.data?[index];
                    return ListTile(
                      title: Text(user?.email ?? ''),
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
        );
      },
    );
  }
}
