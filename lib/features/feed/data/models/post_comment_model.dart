import 'package:snibbo_app/core/models/user_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';

class PostCommentModel {
  String id;
  bool isMyComment;
  bool isLikedByMe;
  UserModel userId;
  String commentContent;
  int commentLikes;
  int commentReplies;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PostCommentModel({
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

  factory PostCommentModel.fromJson(Map<String, dynamic> json) =>
      PostCommentModel(
        id: json["_id"],
        isMyComment: json["isMyComment"],
        isLikedByMe: json["isLikedByMe"],
        userId: UserModel.fromJson(json["userId"]),
        commentContent: json["commentContent"],
        commentLikes: json["commentLikes"],
        commentReplies: json["commentReplies"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  PostCommentEntity toEntity() {
    return PostCommentEntity(
      id: id,
      isMyComment: isMyComment,
      isLikedByMe: isLikedByMe,
      userId: userId.toEntity(),
      commentContent: commentContent,
      commentLikes: commentLikes,
      commentReplies: commentReplies,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }
}

