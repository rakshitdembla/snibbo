import 'package:snibbo_app/core/entities/user_entity.dart';

class UserModel {
  String username;
  String name;
  String? profilePicture;
  bool isVerified;
  bool? hasActiveStories;
  bool? isAllStoriesViewed;
  bool? isMyself;
  bool? isFollowedByMe;
  bool? isOnline;
  DateTime? lastSeen;

  UserModel({
    required this.username,
    required this.name,
    this.profilePicture,
    required this.isVerified,
    this.hasActiveStories,
    this.isAllStoriesViewed,
    this.isMyself,
    this.isFollowedByMe,
    this.isOnline,
    this.lastSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    name: json["name"],
    profilePicture: json["profilePicture"],
    isVerified: json["isVerified"],
    hasActiveStories: json["hasActiveStories"],
    isAllStoriesViewed: json["isAllStoriesViewed"],
    isMyself: json["isMyself"],
    isFollowedByMe: json["isFollowedByMe"],
    isOnline: json["isOnline"],
    lastSeen:
        json["lastSeen"] != null ? DateTime.tryParse(json["lastSeen"]) : null,
  );

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      name: name,
      profilePicture: profilePicture,
      isVerified: isVerified,
      hasActiveStories: hasActiveStories,
      isAllStoriesViewed: isAllStoriesViewed,
      isMyself: isMyself,
      isFollowedByMe: isFollowedByMe,
      isOnline: isOnline,
      lastSeen: lastSeen,
    );
  }
}
