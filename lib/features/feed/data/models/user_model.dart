import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';

class UserModel {
  String username;
  String name;
  String? profilePicture;
  bool isVerified;
  bool? hasActiveStories;
  bool? isAllStoriesViewed;

  UserModel({
    required this.username,
    required this.name,
    this.profilePicture,
    required this.isVerified,
    this.hasActiveStories,
    this.isAllStoriesViewed,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        isVerified: json["isVerified"],
        hasActiveStories: json["hasActiveStories"],
        isAllStoriesViewed: json["isAllStoriesViewed"],
      );

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      name: name,
      profilePicture: profilePicture,
      isVerified: isVerified,
      hasActiveStories: hasActiveStories,
      isAllStoriesViewed: isAllStoriesViewed,
    );
  }
}
