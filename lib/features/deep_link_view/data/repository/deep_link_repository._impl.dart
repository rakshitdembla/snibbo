import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/features/deep_link_view/data/remote/deep_link_remote_data.dart';
import 'package:snibbo_app/features/deep_link_view/domain/repository/deep_link_repository.dart';

class DeepLinkRepoImpl implements DeepLinkRepo {
  final DeepLinkRemoteData remoteDataSource;

  DeepLinkRepoImpl({required this.remoteDataSource});

  @override
  Future<(bool success, PostEntity? postEntity, String? message)> getSinglePostById({
    required String tokenId,
    required String postId,
  }) {
    return remoteDataSource.getSinglePostById(tokenId: tokenId, postId: postId);
  }
}
