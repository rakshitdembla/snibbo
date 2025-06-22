import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

abstract class MessagesEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMessages extends MessagesEvents {
  final String username;

  GetMessages({required this.username});

  @override
  List<Object> get props => [username];
}

class LoadMoreMessages extends MessagesEvents {
  final String username;

  LoadMoreMessages({required this.username});

  @override
  List<Object> get props => [username];
}

class SocketAllMessageSeen extends MessagesEvents {
  final String chatId;

  SocketAllMessageSeen({required this.chatId});
}

class SocketNewMessage extends MessagesEvents {
  final MessageEntity message;

  SocketNewMessage({required this.message});
}

class SendNewMessage extends MessagesEvents {
  final MessageEntity message;

  SendNewMessage({required this.message});
}
