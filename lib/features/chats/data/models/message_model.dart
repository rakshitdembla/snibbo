import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

class MessageModel {
  String id;
  bool isSentByMe;
  String? text;
  String? media;
  bool isSeenByOther;
  DateTime createdAt;

  MessageModel({
    required this.id,
    required this.isSentByMe,
    this.text,
    this.media,
    required this.isSeenByOther,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["_id"],
        isSentByMe: json["isSentByMe"],
        text: json["text"],
        media: json["media"],
        isSeenByOther: json["isSeenByOther"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      isSentByMe: isSentByMe,
      text: text,
      media: media,
      isSeenByOther: isSeenByOther,
      createdAt: createdAt,
    );
  }
}
