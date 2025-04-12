import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../helpers/prefs_helpers.dart';
import '../utils/app_constants.dart';
import 'api_constants.dart';

class SocketServices {
  static final SocketServices _instance = SocketServices._internal();
  factory SocketServices() => _instance;
  SocketServices._internal();

  IO.Socket? socket;
  String bearerToken = '';



  void emitMessagePage(String userId) {
    socket?.emit('message-page', {'userId': userId});
  }

  //=================================> Socket Init <=======================
  Future<void> init() async {
    if (socket != null && socket!.connected) return;
    bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    _connect();
  }

  //==========================> Ensure socket is initialized before emitting events <===================
  void checkSocketInitialized() {
    if (socket == null) {
      print("⚠️ Socket not initialized, calling `init()`...");
      init();
    }
  }

  //================================> Connect the socket <====================================
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
    socket!.onConnect((_) => print('✅ Socket connected'));
    socket!.onDisconnect((_) => print('⚠️ Socket disconnected, retrying...'));
    socket!.onConnectError((err) => print('❌ Socket connection error: $err'));
    socket!.onError((err) => print('🚨 Socket error: $err'));
  }

  //============================> Emit data only if socket is connected <=================================
  void emit(String event, dynamic data) {
    checkSocketInitialized();
    if (socket != null && socket!.connected) {
      socket!.emit(event, data);
      print('📤 Emit: $event \nData: $data');
    } else {
      print("⚠️ Cannot emit, socket not connected.");
    }
  }



  //===================================> Disconnect socket properly <============================================
  void disconnect() {
    socket?.dispose();
    print('🔌 Socket disconnected');
  }
}
