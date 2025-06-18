import 'package:snibbo_app/core/entities/user_entity.dart';

class PostCommentEntity {
  String id;
  bool isMyComment;
  bool isLikedByMe;
  UserEntity userId;
  String commentContent;
  int commentLikes;
  int commentReplies;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PostCommentEntity({
    required this.id,
    required this.isMyComment,
    required this.isLikedByMe,
    required this.userId,
    required this.commentContent,
    required this.commentLikes,
    required this.commentReplies,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}
