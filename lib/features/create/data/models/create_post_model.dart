class CreatePostModel {
  String content;
  String contentType;
  String? captions;

  CreatePostModel({
    required this.content,
    required this.contentType,
    this.captions,
  });

  Map<String, dynamic> toJson() => {
    "content": content,
    "contentType": contentType,
    "captions": captions,
  };
}
