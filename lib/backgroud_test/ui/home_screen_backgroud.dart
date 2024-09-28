import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playground/backgroud_test/background_services/background_service_provider.dart';

class HomeScreenBackgroud extends StatefulWidget {
  const HomeScreenBackgroud({super.key});

  @override
  State<HomeScreenBackgroud> createState() => _HomeScreenBackgroudState();
}

class _HomeScreenBackgroudState extends State<HomeScreenBackgroud> {
  @override
  void initState() {
    super.initState();
    askPermissions();
    intialize();
  }

  void intialize() async {
    await initializeService();
  }

  void askPermissions() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    await Permission.location.isDenied.then((value) {
      if (value) {
        Permission.location.request();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Service Test'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              startBackgroundService();
            },
            child: const Text('START'),
          ),
          ElevatedButton(
            onPressed: () {
              stopBackgroundService();
            },
            child: const Text('STOP'),
          ),
        ],
      ),
    );
  }
}
