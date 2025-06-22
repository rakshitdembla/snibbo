import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/chats/data/models/message_req_model.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_bloc.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_messages_bloc/get_messages_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class WebSocketsServices {
  late final socket_io.Socket _socket;
  late final String? userId;
  Timer? _typingTimer;

  final StreamController<Map<String, dynamic>> _eventStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get socketStream =>
      _eventStreamController.stream;

  Future<void> connectToSocket({required BuildContext context}) async {
    _socket = socket_io.io(
      ApiMainUrl.baseUrl,
      socket_io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      debugPrint('🟢 Connected: ${_socket.id}');
      emitAuthUser();
      onTypingEvents();
      onMessagesSeen(context: context);
      onNewMessage(context: context);
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

  Future<void> emitAuthUser() async {
    userId = await ServicesUtils.getTokenId();

    try {
      _socket.emit("auth-user", userId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> emitjoinChats({required List<String> roomIds}) async {
    debugPrint("emiited join chat event $roomIds");
    try {
      _socket.emit("join-chat", [roomIds]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onChangedTyping({required String chatId}) async {
    try {
      _socket.emit("typing", {"roomId": chatId, "userId": userId});
      debugPrint("Emitting typing from: ${_socket.id}");

      _typingTimer?.cancel();

      _typingTimer = Timer(Duration(seconds: 2), () {
        _socket.emit("stop-typing", {"roomId": chatId, "userId": userId});
      });
    } catch (e) {
      debugPrint("Typing error: ${e.toString()}");
    }
  }

  Future<void> emitNewMessage({
    required String chatId,
    String? text,
    String? media,
    required BuildContext context,
  }) async {
    try {
      _socket.emit(
        "new-message",
        MessageRequestModel(
          chat: chatId,
          sender: userId!,
          text: text,
          media: media,
          seenBy: [userId!],
        ).toJson(),
      );

      final getMessage = MessageEntity(
            text: text,
            media: media,
            id: "",
            isSentByMe: true,
            chat: chatId,
            isSeenByOther: false,
            createdAt: DateTime.now(),
          );

      BlocProvider.of<MessagesBloc>(context).add(
        SendNewMessage(
          message: getMessage
        ),
      );

        BlocProvider.of<ChatsListBloc>(
        context,
        ).add(UpdateLastMessage(message: getMessage));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> emitMessagesSeen({required String chatId}) async {
    try {
      _socket.emit("messages-seen", {"roomId": chatId, "userId": userId});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onTypingEvents() async {
    try {
      _socket.on("typing", (roomId) {
        debugPrint("🔥 Typing received from: $userId");
        _eventStreamController.add({"type": "typing", "data": roomId});
      });

      _socket.on("stop-typing", (roomId) {
        debugPrint("User stopped typing..");
        _eventStreamController.add({"type": "stop-typing", "data": roomId});
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onMessagesSeen({required BuildContext context}) async {
    try {
      _socket.on("messages-seen", (chatId) {
        debugPrint("All messages seen event received for $chatId");
        BlocProvider.of<MessagesBloc>(
          context,
        ).add(SocketAllMessageSeen(chatId: chatId.toString()));

        BlocProvider.of<ChatsListBloc>(
          context,
        ).add(UpdateMessageSeenStatus(chatId: chatId.toString()));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onNewMessage({required BuildContext context}) async {
    try {
      _socket.on("new-message", (message) {
        debugPrint("New Message event received $message");

        final getMessage = MessageEntity(
          text: message['text'],
          media: message['media'],
          id: message['_id'],
          isSentByMe: message['sender'].toString() == userId,
          chat: message['chat'],
          isSeenByOther: false,
          createdAt: DateTime.parse(message['createdAt']),
        );

        BlocProvider.of<MessagesBloc>(
          context,
        ).add(SocketNewMessage(message: getMessage));

        BlocProvider.of<ChatsListBloc>(
          context,
        ).add(UpdateLastMessage(message: getMessage));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
