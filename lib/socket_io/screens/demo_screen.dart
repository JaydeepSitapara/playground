import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:playground/socket_io/data/socket_io_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});
  @override
  State<DemoScreen> createState() {
    return _DemoScreenState();
  }
}

class _DemoScreenState extends State<DemoScreen> {
  IO.Socket? socket;
  @override
  void initState() {
    super.initState();
    SocketIoServices.initSocket();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket IO'),
      ),
      body: const Center(
        child: Text('Socket IO'),
      ),
    );
  }
}
