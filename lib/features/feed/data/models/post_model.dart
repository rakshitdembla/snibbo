import 'package:snibbo_app/features/feed/data/models/user_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class PostModel {
  String id;
  UserModel userId;
  String postContent;
  String? postCaption;
  List<String> postLikes;
  List<String> postComments;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PostModel({
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

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["_id"],
    userId: UserModel.fromJson(json["userId"]),
    postContent: json["postContent"],
    postCaption: json["postCaption"] ?? "",
    postLikes: List<String>.from(json["postLikes"]),
    postComments: List<String>.from(json["postComments"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      userId: UserEntity(
        username: userId.username,
        name: userId.name,
        isVerified: userId.isVerified,
      ),
      postContent: postContent,
      postCaption: postCaption,
      postLikes: postLikes,
      postComments: postComments,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }
}
