class UserEntity {
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

  UserEntity({
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
}
