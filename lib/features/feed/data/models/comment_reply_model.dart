import 'package:snibbo_app/core/models/user_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/comment_reply_entity.dart';

class CommentReplyModel {
  String id;
  bool isMyReply;
  bool isLikedByMe;
  UserModel userId;
  String replyContent;
  int replyLikes;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CommentReplyModel({
    required this.id,
    required this.isMyReply,
    required this.isLikedByMe,
    required this.userId,
    required this.replyContent,
    required this.replyLikes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CommentReplyModel.fromJson(Map<String, dynamic> json) => CommentReplyModel(
        id: json["_id"],
        isMyReply: json["isMyreply"],
        isLikedByMe: json["isLikedByMe"],
        userId: UserModel.fromJson(json["userId"]),
        replyContent: json["replyContent"],
        replyLikes: json["replyLikes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  CommentReplyEntity toEntity() {
    return CommentReplyEntity(
      id: id,
      isMyReply: isMyReply,
      isLikedByMe: isLikedByMe,
      userId: userId.toEntity(),
      replyContent: replyContent,
      replyLikes: replyLikes,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }
}
