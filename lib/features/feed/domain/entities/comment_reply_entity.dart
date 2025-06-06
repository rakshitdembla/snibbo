import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class CommentReplyEntity {
  String id;
  bool isMyReply;
  bool isLikedByMe;
  UserEntity userId;
  String replyContent;
  int replyLikes;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CommentReplyEntity({
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
}
