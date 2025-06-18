import 'package:snibbo_app/core/models/user_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

class PostModel {
  String id;
  UserModel userId;
  String postContent;
  String? postCaption;
  int likesLength;
  int commentsLength;
  DateTime createdAt;
  DateTime updatedAt;
  bool isLikedByMe;
  bool isSavedByMe;
  bool isMyPost;

  PostModel({
    required this.id,
    required this.userId,
    required this.postContent,
    this.postCaption,
    required this.likesLength,
    required this.commentsLength,
    required this.createdAt,
    required this.updatedAt,
    required this.isLikedByMe,
    required this.isSavedByMe,
    required this.isMyPost,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["_id"],
    userId: UserModel.fromJson(json["userId"]),
    postContent: json["postContent"],
    postCaption: json["postCaption"] ?? "",
    likesLength: json["likesLength"],
    commentsLength: json["commentsLength"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    isLikedByMe: json["isLikedByMe"],
    isSavedByMe: json["isSavedByMe"],
    isMyPost: json["isMyPost"],
  );

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      userId: userId.toEntity(),
      postContent: postContent,
      postCaption: postCaption,
      likesLength: likesLength,
      commentsLength: commentsLength,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isLikedByMe: isLikedByMe,
      isSavedByMe: isSavedByMe,
      isMyPost: isMyPost,
    );
  }
}
