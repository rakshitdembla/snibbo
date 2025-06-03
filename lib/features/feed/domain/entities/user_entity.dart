class UserEntity {
  String username;
  String name;
  String? profilePicture;
  bool isVerified;
  bool? hasActiveStories;
  bool? isAllStoriesViewed;

  UserEntity({
    required this.username,
    required this.name,
    this.profilePicture,
    required this.isVerified,
    this.hasActiveStories,
    this.isAllStoriesViewed,
  });
}
