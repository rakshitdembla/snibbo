import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/user/domain/repositories/user_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class GetUserSavedPostsUsecase {
  Future<(bool, List<PostEntity>?, String?)> call({
    required int page,
    required int limit,
    required String username,
    required String userId,
  }) {
    return sl<UserRepository>().getUserSavedPosts(
      page: page,
      limit: limit,
      username: username,
      userId: userId,
    );
  }
}
