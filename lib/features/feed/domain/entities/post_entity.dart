import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class PostEntity {
  String id;
  UserEntity userId;
  String postContent;
  String? postCaption;
  List<String> postLikes;
  List<String> postComments;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PostEntity({
    required this.id,
    required this.userId,
    required this.postContent,
    required this.postCaption,
    required this.postLikes,
    required this.postComments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}
