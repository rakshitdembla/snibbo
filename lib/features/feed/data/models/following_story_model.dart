
import 'package:snibbo_app/features/feed/domain/entities/following_story_entity.dart';

class FollowingStoryModel {
  String username;
  String name;
  String profilePicture;
  List<String> userStories;
  bool isVerified;

  FollowingStoryModel({
    required this.username,
    required this.name,
    required this.profilePicture,
    required this.userStories,
    required this.isVerified,
  });

  factory FollowingStoryModel.fromJson(Map<String, dynamic> json) =>
      FollowingStoryModel(
        username: json["username"],
        name: json["name"],
        profilePicture: json["profilePicture"] ?? "",
        userStories: List<String>.from(
          json["userStories"].map((x) => x['_id']),
        ),
        isVerified: json["isVerified"],
      );

  FollowingStoryEntity toEntity() {
    return FollowingStoryEntity(
      username: username,
      name: name,
      profilePicture: profilePicture,
      userStories: userStories,
      isVerified: isVerified,
    );
  }
}
