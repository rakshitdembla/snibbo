class MessageEntity {
  String id;
  bool isSentByMe;
  String? text;
  String? media;
  bool isSeenByOther;
  DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.isSentByMe,
    this.text,
    this.media,
    required this.isSeenByOther,
    required this.createdAt,
  });
}
