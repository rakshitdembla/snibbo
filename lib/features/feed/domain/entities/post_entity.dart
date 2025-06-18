import 'package:snibbo_app/core/entities/user_entity.dart';

class PostEntity {
  String id;
  UserEntity userId;
  String postContent;
  String? postCaption;
  int likesLength;
  int commentsLength;
  DateTime createdAt;
  DateTime updatedAt;
  bool isLikedByMe;
  bool isSavedByMe;
  bool isMyPost;

  PostEntity({
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
}

