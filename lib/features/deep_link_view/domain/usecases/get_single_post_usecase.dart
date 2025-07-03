import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/deep_link_view/domain/repository/deep_link_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class GetSinglePostUsecase {

  Future<(bool, PostEntity?, String?)> getSinglePostById({
    required String tokenId,
    required String postId,
  }) async {
    return await sl<DeepLinkRepo>().getSinglePostById(
      tokenId: tokenId,
      postId: postId,
    );
  }
}
