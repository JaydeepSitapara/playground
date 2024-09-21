import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIoServices {
  static IO.Socket? socket;
  static initSocket() {
    log('Init Socket..');



    socket = IO.io(
      'http://10.0.2.2:3000',
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    socket?.connect();
    socket?.onConnect((data) {
      log('Connected established...');
    });


    socket?.onConnectError((data) => log('error: ${data.toString()}'));
    socket?.onDisconnect((data) => log('Error: ${data.toString()}'));
  }
}
