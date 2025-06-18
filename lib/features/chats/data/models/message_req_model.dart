class MessageRequestModel {
  String chat;
  String sender; 
  String? text;
  String? media;
  List<String>? seenBy;

  MessageRequestModel({
    required this.chat,
    required this.sender,
    this.text,
    this.media,
    this.seenBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "chat": chat,
      "sender": sender,
      "text": text,
      "media": media,
      "seenBy": seenBy,
    };
  }
}
