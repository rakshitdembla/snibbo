import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

class ChatListEntity {
  String id;
  MessageEntity lastMessage;
  UserEntity participantInfo;
  bool isBlocked;
  bool isBlockedByMe;

  ChatListEntity({
    required this.id,
    required this.lastMessage,
    required this.participantInfo,
    required this.isBlocked,
    required this.isBlockedByMe,
  });
}
