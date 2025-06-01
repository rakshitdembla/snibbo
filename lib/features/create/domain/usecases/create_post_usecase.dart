import 'package:snibbo_app/features/create/data/models/create_post_model.dart';
import 'package:snibbo_app/features/create/domain/repositories/content_creator_repository.dart';

class CreatePostUsecase {
  final ContentCreatorRepository contentCreatorRepository;

  CreatePostUsecase({required this.contentCreatorRepository});

  Future<(bool success, String? message)> createPost({
    required CreatePostModel createPostModel,
    required String userId,
  }) async {
    return contentCreatorRepository.createPost(
      createPostModel: createPostModel,
      userId: userId,
    );
  }
}
