import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../helpers/prefs_helpers.dart';
import '../service/api_constants.dart';
import '../utils/app_constants.dart';

class SocketServices {
  static final SocketServices _instance = SocketServices._internal();
  factory SocketServices() => _instance;
  SocketServices._internal();

  late IO.Socket socket;
  String bearerToken = '';

  //===========================> Socket Init Method <========================
  Future<void> init() async {
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    _connect();
  }

  //===========================> Socket Connect Method <========================
  void _connect() {
    socket = IO.io(
      ApiConstants.socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({"authorization": 'Bearer $bearerToken'})
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .build(),
    );

    socket.onConnect((_) => print('✅ Socket connected'));
    socket.onDisconnect((_) => print('⚠️ Socket disconnected, retrying...'));
    socket.onConnectError((err) => print('❌ Socket connection error: $err'));
    socket.onError((err) => print('🚨 Socket error: $err'));
  }

  //===========================> Socket Emit Method <========================
  void emit(String event, dynamic data) {
    if (socket.connected) {
      socket.emit(event, data);
      print('📤 Emit: $event \nData: $data');
    } else {
      print('⚠️ Cannot emit, socket not connected.');
    }
  }

  //===========================> Socket Emit With Ack Method <========================
  Future<dynamic> emitWithAck(String event, dynamic data) async {
    if (!socket.connected) {
      print('⚠️ Cannot emit, socket not connected.');
      return Future.value(null);
    }

    final Completer<dynamic> completer = Completer<dynamic>();
    socket.emitWithAck(event, data, ack: (response) {
      completer.complete(response ?? 1);
    });
    return completer.future;
  }

  //===========================> Socket Disconnect Method <========================
  void disconnect() {
    socket.dispose();
    print('🔌 Socket disconnected');
  }
}
