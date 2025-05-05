class UserStoriesEntity {
  String username;
  String name;
  String profilePicture;
  List<StoryEntitiy> userStories;
  bool isVerified;

  UserStoriesEntity({
    required this.username,
    required this.name,
    required this.profilePicture,
    required this.userStories,
    required this.isVerified,
  });
}

class StoryEntitiy {
  String id;
  String contentType;
  String storyContent;
  List<dynamic> storyViews;
  DateTime createdAt;
  int v;

  StoryEntitiy({
    required this.id,
    required this.contentType,
    required this.storyContent,
    required this.storyViews,
    required this.createdAt,
    required this.v,
  });
}
