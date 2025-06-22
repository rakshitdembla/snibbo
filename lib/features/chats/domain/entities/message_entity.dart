class MessageEntity {
  String id;
  String chat;
  bool isSentByMe;
  String? text;
  String? media;
  bool isSeenByOther;
  DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.isSentByMe,
    required this.chat,
    this.text,
    this.media,
    required this.isSeenByOther,
    required this.createdAt,
  });
}
