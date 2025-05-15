import 'package:snibbo_app/features/create/data/models/create_story_model.dart';
import 'package:snibbo_app/features/create/domain/repositories/content_creator_repository.dart';

class CreateStoryUsecase {
  final ContentCreatorRepository contentCreatorRepository;

  CreateStoryUsecase({required this.contentCreatorRepository});

  Future<(bool success, String? message)> call({
    required CreateStoryModel createStoryModel,
    required String userId,
  }) {
    return contentCreatorRepository.createStory(
      createStoryModel: createStoryModel,
      userId: userId,
    );
  }
}
