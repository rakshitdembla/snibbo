import 'package:equatable/equatable.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

abstract class ChatsListEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetChatsList extends ChatsListEvents {}

class LoadMoreChatsList extends ChatsListEvents {}

class UpdateMessageSeenStatus extends ChatsListEvents {
  final String chatId;

  UpdateMessageSeenStatus({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class UpdateLastMessage extends ChatsListEvents {
  final MessageEntity message;

  UpdateLastMessage({required this.message});

  @override
  List<Object> get props => [message.id];
}


