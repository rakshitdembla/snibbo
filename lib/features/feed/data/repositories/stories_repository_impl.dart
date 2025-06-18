import 'package:snibbo_app/features/feed/data/data_sources/remote/stories_remote_data.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/stories_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  @override
  Future<(bool, String?)> deleteStory({
    required String userId,
    required String storyId,
  }) {
    return sl<StoriesRemoteData>().deleteStory(
      userId: userId,
      storyId: storyId,
    );
  }

  @override
  Future<(bool, List<UserEntity>?, String?)> storyViewers({
    required String userId,
    required String storyId,
  }) {
    return sl<StoriesRemoteData>().storyViewers(
      userId: userId,
      storyId: storyId,
    );
  }

  @override
  Future<(bool, String?)> viewStory({
    required String userId,
    required String storyId,
  }) {
    return sl<StoriesRemoteData>().viewStory(userId: userId, storyId: storyId);
  }

  @override
  Future<(bool, UserStoriesEntity?, String?)> getUserStories(String username) {
    return sl<StoriesRemoteData>().getUserStories(username);
  }
}
