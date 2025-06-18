import 'package:flutter/foundation.dart';
import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class WebSocketsServices {

   late final socket_io.Socket _socket;

  Future<void> connectToSocket() async {

    _socket = socket_io.io(
      ApiMainUrl.baseUrl,
      socket_io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      debugPrint('🟢 Connected: ${_socket.id}');
    });

    _socket.onConnectError((data) {
      debugPrint("❌ Connect Error: $data");
    });

    _socket.onError((data) {
      debugPrint("❌ Error: $data");
    });

    _socket.onDisconnect((_) {
      debugPrint("🔴 Disconnected from socket");
    });
  }

  Future<void> onAuthUser () async {
    final userId = await ServicesUtils.getTokenId();

    _socket.emit("auth-user",userId);
  }
}
