import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/presentation/pages/fetch_stories_loading.dart';

@RoutePage()
class FetchStoriesLoadingSlidePage extends StatelessWidget {
  final UserEntity user;
  final String profilePicture;
  final List<UserEntity> storyUsers;

  const FetchStoriesLoadingSlidePage({
    super.key,
    required this.user,
    required this.storyUsers,
    required this.profilePicture
  });

  @override
  Widget build(BuildContext context) {
    return FetchStoriesLoading(
      username: user.username,
      isPreviousSlide: true,
      profilePicture: profilePicture,
      storyUsers: storyUsers,
    );
  }
}
