import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class PostPaginationEvents {}

class LoadMorePosts extends PostPaginationEvents {}

class InitializePaginationPosts extends PostPaginationEvents {
  final List<PostEntity> initialPosts;

  InitializePaginationPosts({required this.initialPosts});
}
