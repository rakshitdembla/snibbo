import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

abstract class DeepLinkRepo {
  Future<(bool success, PostEntity? postEntity, String? message)> getSinglePostById({
    required String tokenId,
    required String postId,
  });
}
