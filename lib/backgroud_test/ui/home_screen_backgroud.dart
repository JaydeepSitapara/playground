import 'package:carp_background_location/carp_background_location.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playground/backgroud_test/background_services/background_service_provider.dart';

class HomeScreenBackgroud extends StatefulWidget {
  const HomeScreenBackgroud({super.key});

  @override
  State<HomeScreenBackgroud> createState() => _HomeScreenBackgroudState();
}

class _HomeScreenBackgroudState extends State<HomeScreenBackgroud> {
  final LocationManager locationManager = LocationManager();
  @override
  void initState() {
    super.initState();
    initializeService();
    askPermissions();
  }

  void askPermissions() async {
   // Permission.notification.request();
    Permission.location.request();
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
            onPressed: () async {
              startBackgroundService();            },
            child: const Text('START'),
          ),
          ElevatedButton(
            onPressed: () {
              stopBackgroundService();
              LocationManager().stop();
            },
            child: const Text('STOP'),
          ),
        ],
      ),
    );
  }
}
