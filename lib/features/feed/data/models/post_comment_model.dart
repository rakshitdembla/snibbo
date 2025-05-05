import 'package:snibbo_app/features/feed/data/models/user_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_comment_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class PostCommentModel {
  String id;
  UserModel userId;
  String commentContent;
  List<dynamic> commentLike;
  List<dynamic> commentReplies;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PostCommentModel({
    required this.id,
    required this.userId,
    required this.commentContent,
    required this.commentLike,
    required this.commentReplies,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) =>
      PostCommentModel(
        id: json["_id"],
        userId: UserModel.fromJson(json["userId"]),
        commentContent: json["commentContent"],
        commentLike: List<dynamic>.from(json["commentLike"]),
        commentReplies: List<dynamic>.from(json["commentReplies"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  PostCommentEntity toEntity() {
    return PostCommentEntity(
      id: id,
      userId: UserEntity(
        username: userId.username,
        name: userId.name,
        isVerified: userId.isVerified,
      ),
      commentContent: commentContent,
      commentLike: commentLike,
      commentReplies: commentReplies,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }
}
