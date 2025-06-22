import 'package:snibbo_app/core/models/user_model.dart';
import 'package:snibbo_app/features/chats/data/models/message_model.dart';
import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';

class ChatListModel {
  String id;
  MessageModel? lastMessage;
  UserModel participantInfo;
  bool isBlocked;
  bool isBlockedByMe;

  ChatListModel({
    required this.id,
    required this.lastMessage,
    required this.participantInfo,
    required this.isBlocked,
    required this.isBlockedByMe,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      id: json["_id"],
      lastMessage: json["lastMessage"] != null ? MessageModel.fromJson(json["lastMessage"]) : null,
      participantInfo: UserModel.fromJson(json["participantInfo"]),
      isBlocked: json["isBlocked"],
      isBlockedByMe: json["isBlockedByMe"],
    );
  }

  ChatListEntity toEntity() {
    return ChatListEntity(
      id: id,
      lastMessage: lastMessage?.toEntity(),
      participantInfo: participantInfo.toEntity(),
      isBlocked: isBlocked,
      isBlockedByMe: isBlockedByMe,
    );
  }
}
