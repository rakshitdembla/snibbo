import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class PostCommentEntity {
    String id;
    UserEntity userId;
    String commentContent;
    List<dynamic> commentLike;
    List<dynamic> commentReplies;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    PostCommentEntity({
        required this.id,
        required this.userId,
        required this.commentContent,
        required this.commentLike,
        required this.commentReplies,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

}