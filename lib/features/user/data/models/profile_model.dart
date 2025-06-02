import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';

class ProfileModel {
  String username;
  String name;
  String profilePicture;
  String bio;
  bool isVerified;
  dynamic lastSeen;
  bool isOnline;
  DateTime createdAt;
  int posts;
  int userFollowers;
  int userFollowing;
  bool hasActiveStories;
  bool viewedAllStories;
  bool isFollowedByMe;

  ProfileModel({
    required this.username,
    required this.name,
    required this.profilePicture,
    required this.bio,
    required this.isVerified,
    required this.lastSeen,
    required this.isOnline,
    required this.createdAt,
    required this.posts,
    required this.userFollowers,
    required this.userFollowing,
    required this.hasActiveStories,
    required this.viewedAllStories,
    required this.isFollowedByMe,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    username: json["username"],
    name: json["name"],
    profilePicture: json["profilePicture"],
    bio: json["bio"],
    isVerified: json["isVerified"],
    lastSeen: json["lastSeen"],
    isOnline: json["isOnline"],
    createdAt: DateTime.parse(json["createdAt"]),
    posts: json["posts"],
    userFollowers: json["userFollowers"],
    userFollowing: json["userFollowing"],
    hasActiveStories: json["hasActiveStories"],
    viewedAllStories: json["viewedAllStories"],
    isFollowedByMe: json["isFollowedByMe"],
  );

  ProfileEntity toEntity() {
    return ProfileEntity(
      username: username,
      name: name,
      profilePicture: profilePicture,
      bio: bio,
      isVerified: isVerified,
      lastSeen: lastSeen,
      isOnline: isOnline,
      createdAt: createdAt,
      posts: posts,
      userFollowers: userFollowers,
      userFollowing: userFollowing,
      hasActiveStories: hasActiveStories,
      viewedAllStories: viewedAllStories,
      isFollowedByMe: isFollowedByMe,
    );
  }
}
