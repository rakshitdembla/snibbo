abstract class UserStoriesEvents {}

class GetUserStories extends UserStoriesEvents {
  final String username;

  GetUserStories({required this.username});
}
