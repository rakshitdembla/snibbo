import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class ExploreRepositories {
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getExplorePosts(String userId, int page, int limit);
}
