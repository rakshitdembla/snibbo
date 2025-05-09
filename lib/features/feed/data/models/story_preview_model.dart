
import 'package:snibbo_app/features/feed/domain/entities/story_preview_entity.dart';

class UserStoryPreviewModel {
  String username;
  String name;
  String profilePicture;
  List<String> userStories;
  bool isVerified;

  UserStoryPreviewModel({
    required this.username,
    required this.name,
    required this.profilePicture,
    required this.userStories,
    required this.isVerified,
  });

  factory UserStoryPreviewModel.fromJson(Map<String, dynamic> json) =>
      UserStoryPreviewModel(
        username: json["username"],
        name: json["name"],
        profilePicture: json["profilePicture"] ?? "",
        userStories: List<String>.from(
          json["userStories"],
        ),
        isVerified: json["isVerified"],
      );

  UserStoryPreviewEntity toEntity() {
    return UserStoryPreviewEntity(
      username: username,
      name: name,
      profilePicture: profilePicture,
      userStories: userStories,
      isVerified: isVerified,
    );
  }
}
