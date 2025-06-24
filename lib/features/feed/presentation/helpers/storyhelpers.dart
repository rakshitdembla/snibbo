import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class StoryHelpers {
  void goToNextStory(
    String username,
    List<UserEntity> storyUsers,
    BuildContext context,
  ) {
    final int currentIndex = storyUsers.indexWhere(
      (user) => user.username == username,
    );

    final int nextIndex = currentIndex + 1;

    if (nextIndex < storyUsers.length) {
      final UserEntity nextUser = storyUsers[nextIndex];

      if (context.mounted) {
        context.router.replace(
          FetchStoriesLoadingRoute(
            key: ValueKey(nextUser.username),
            username: nextUser.username,
            isPreviousSlide: false,
            storyUsers: storyUsers,
            profilePicture: nextUser.profilePicture.toString(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        context.router.popUntilRoot();
      }
    }
  }

  void goToPreviousStory(
    String username,
    List<UserEntity> storyUsers,
    BuildContext context,
  ) {
    final int currentIndex = storyUsers.indexWhere(
      (user) => user.username == username,
    );

    final int previousIndex = currentIndex - 1;

    if (previousIndex >= 0) {
      final previousUser = storyUsers[previousIndex];
      if (context.mounted) {
              context.router.replace(
          FetchStoriesLoadingRoute(
            key: ValueKey(previousUser.username),
            username: previousUser.username,
            isPreviousSlide: false,
            storyUsers: storyUsers,
            profilePicture: previousUser.profilePicture.toString(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        context.router.popUntilRoot();
      }
    }
  }
}
