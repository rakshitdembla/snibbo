import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';

class UserStoriesModel {
  String username;
  String name;
  String profilePicture;
  List<StoryModel> userStories;
  bool isVerified;

  UserStoriesModel({
    required this.username,
    required this.name,
    required this.profilePicture,
    required this.userStories,
    required this.isVerified,
  });

  factory UserStoriesModel.fromJson(Map<String, dynamic> json) =>
      UserStoriesModel(
        username: json["username"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        userStories: List<StoryModel>.from(
          json["userStories"].map((x) => StoryModel.fromJson(x)),
        ),
        isVerified: json["isVerified"],
      );

  UserStoriesEntity toEntity() {
    return UserStoriesEntity(
      username: username,
      name: name,
      profilePicture: profilePicture,
      userStories:
          userStories
              .map(
                (story) => StoryEntitiy(
                  id: story.id,
                  contentType: story.contentType,
                  storyContent: story.storyContent,
                  storyViews: story.storyViews,
                  createdAt: story.createdAt,
                  v: story.v,
                ),
              )
              .toList(),
      isVerified: isVerified,
    );
  }
}

class StoryModel {
  String id;
  String contentType;
  String storyContent;
  List<dynamic> storyViews;
  DateTime createdAt;
  int v;

  StoryModel({
    required this.id,
    required this.contentType,
    required this.storyContent,
    required this.storyViews,
    required this.createdAt,
    required this.v,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    id: json["_id"],
    contentType: json["contentType"],
    storyContent: json["storyContent"],
    storyViews: List<dynamic>.from(json["storyViews"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );
}
