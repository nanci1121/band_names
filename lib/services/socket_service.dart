// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Conneting }

class SocketService with ChangeNotifier {
  late ServerStatus _serverStatus = ServerStatus.Conneting;
  IO.Socket? _socket;
  ServerStatus get serverStatus => _serverStatus;
  IO.Socket? get socket => _socket;
  void Function(String event, [dynamic data])? get emit => _socket?.emit;

  SocketService() {
    _initConfig();
  }
  void _initConfig() {
    // Dart client
    _socket = IO.io('http://192.168.1.200:3000',
        OptionBuilder().setTransports(['websocket']).build());

    _socket!.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      _socket!.emit('mensaje', ' test desde flutter Conectado');
      notifyListeners();
    });
    _socket!.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
