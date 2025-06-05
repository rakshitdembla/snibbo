import 'package:snibbo_app/features/explore/domain/repositories/explore_repositories.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class GetExplorePostsUsecase {
  Future<(bool, List<PostEntity>?, String?)> call(
   {
    required String userId,
    required int page,
    required int limit
   }
  ) {
    return sl<ExploreRepositories>().getExplorePosts(userId, page, limit);
  }
}
