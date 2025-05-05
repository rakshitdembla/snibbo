import 'package:snibbo_app/features/feed/domain/entities/user_stories_entity.dart';
import 'package:snibbo_app/features/feed/domain/repositories/feed_repository.dart';

class FeedStoriesUsecase {
  final FeedRepository feedRepository;

  FeedStoriesUsecase({required this.feedRepository});

  Future<(bool success, UserStoriesEntity? userStories, String? message)>
  getUserStories(String username) {
    return feedRepository.getUserStories(username);
  }
}
