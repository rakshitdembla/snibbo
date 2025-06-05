import 'package:snibbo_app/features/explore/data/data_sources/remote/explore_remote_data.dart';
import 'package:snibbo_app/features/explore/domain/repositories/explore_repositories.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class ExploreRepositoriesImpl implements ExploreRepositories {
  @override
  Future<(bool, List<PostEntity>?, String?)> getExplorePosts(String userId, int page, int limit) {
   return sl<ExploreRemoteData>().getExplorePosts(userId, page, limit);
  }

}