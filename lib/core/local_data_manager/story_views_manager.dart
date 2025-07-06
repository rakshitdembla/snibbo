import 'package:flutter/widgets.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';

class StoryViewsManager {
  static final Map<String, bool> storyViewStatus = {};
  static final ValueNotifier<int> refreshTrigger = ValueNotifier(0);

  static void _notify() => refreshTrigger.value++;

  static void clearAll() {
    storyViewStatus.clear();
    _notify();
  }

  static void clearStoriesByPosts({required List<PostEntity> posts}) {
    for (final post in posts) {
      final username = post.userId.username;
      storyViewStatus.remove(username);
      StoryViewsManager.storyViewStatus[username] =
          post.userId.isAllStoriesViewed ?? false;
    }
    _notify();
  }

  static void clearStoriesByUsers({required List<UserEntity> users}) {
    for (final user in users) {
      final username = user.username;
      storyViewStatus.remove(username);
      StoryViewsManager.storyViewStatus[username] =
          user.isAllStoriesViewed ?? false;
    }
    _notify();
  }

  static void clearStoriesByChats({required List<ChatListEntity> chats}) {
    for (final chat in chats) {
      final username = chat.participantInfo.username;
      storyViewStatus.remove(username);
      StoryViewsManager.storyViewStatus[username] =
          chat.participantInfo.isAllStoriesViewed ?? false;
    }
    _notify();
  }

  static void clearStoryByProfile({required ProfileEntity profile}) {
    final username = profile.username;
    storyViewStatus.remove(username);
    StoryViewsManager.storyViewStatus[username] == profile.viewedAllStories;
    _notify();
  }
}
