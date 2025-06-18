import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/presentation/pages/story_view_screen.dart';

@RoutePage()
class StoryViewSlidePage extends StatelessWidget {
  final List<StoryEntitiy> stories;
  final List<UserEntity>? storyUsers;
  final String username;
  final String profilePicture;
  final bool isMyStory;

  const StoryViewSlidePage({
    super.key,
    required this.stories,
    required this.username,
    required this.profilePicture,
    required this.isMyStory,
    this.storyUsers,
  });

  @override
  Widget build(BuildContext context) {
    return StoryViewScreen(
      stories: stories,
      username: username,
      profilePicture: profilePicture,
      isMyStory: isMyStory,
      storyUsers: storyUsers,
    );
  }
}
