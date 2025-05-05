class FollowingStoryEntity {
  String username;
  String name;
  String profilePicture;
  List<String> userStories;
  bool isVerified;

  FollowingStoryEntity({
    required this.username,
    required this.name,
    required this.profilePicture,
    required this.userStories,
    required this.isVerified,
  });
}