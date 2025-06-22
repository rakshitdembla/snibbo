import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

class MessageModel {
  String id;
  String chat;
  bool isSentByMe;
  String? text;
  String? media;
  bool isSeenByOther;
  DateTime createdAt;

  MessageModel({
    required this.id,
    required this.isSentByMe,
    required this.chat,
    this.text,
    this.media,
    required this.isSeenByOther,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["_id"],
        isSentByMe: json["isSentByMe"],
        chat: json["chat"],
        text: json["text"],
        media: json["media"],
        isSeenByOther: json["isSeenByOther"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      isSentByMe: isSentByMe,
      chat: chat,
      text: text,
      media: media,
      isSeenByOther: isSeenByOther,
      createdAt: createdAt,
    );
  }
}
