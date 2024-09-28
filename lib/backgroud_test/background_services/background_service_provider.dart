import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:carp_background_location/carp_background_location.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
}

void stopBackgroundService() {
  final service = FlutterBackgroundService();
  service.invoke("stop");
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: false,
      isForegroundMode: false,

      notificationChannelId:
          'my_foreground', // this must match with notification channel you created above.
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration:
        IosConfiguration(autoStart: true, onBackground: onIosBackground),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final LocationManager locationManager = LocationManager();
  // bring to foreground
  Timer.periodic(const Duration(seconds: 10), (timer) async {
    if (service is AndroidServiceInstance) {


        try {
          LocationDto location = await locationManager.getCurrentLocation();
          //log('Current location1 : ${location.latitude} - ${location.longitude}');
          await addLatLong(location);
        } catch (e) {
          log('Error in background service : ${e.toString()}');
        }

        log('BACKGROUND SERVICE RUNNING');
        // LocationDto location = await locationManager.getCurrentLocation();
        // log('Current location2'
        //     ' : ${location.latitude} - ${location.longitude}');

        flutterLocalNotificationsPlugin.show(
          888,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

    }
  });
}

Future<void> addLatLong(LocationDto location) async {
  log('Current lat-long : ${location.latitude} - ${location.longitude}');
  final Dio dio = Dio();
  String url = "https://api.restful-api.dev/objects";
  try {
    final response = await dio.post(
      url,
      data: {
        "data": {
          "lat": location.latitude,
          "long": location.longitude,
        },
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Resposne : ${response.data['data']}');
    }
  } catch (e) {
    log('error in add Lt-Long : ${e.toString()}');
  }
}
