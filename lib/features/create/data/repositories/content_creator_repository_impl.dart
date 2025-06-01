import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snibbo_app/features/create/data/data_sources/remote/content_creator_remote_data.dart';
import 'package:snibbo_app/features/create/data/models/create_post_model.dart';
import 'package:snibbo_app/features/create/data/models/create_story_model.dart';
import 'package:snibbo_app/features/create/domain/repositories/content_creator_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class ContentCreatorRepositoryImpl implements ContentCreatorRepository {
  @override
  Future<(bool, String?)> createStory({
    required CreateStoryModel createStoryModel,
    required String userId,
  }) {
    return sl<ContentCreatorRemoteData>().createStory(
      createStoryModel: createStoryModel,
      userId: userId,
    );
  }

  @override
  Future<(bool, String?, String?)> uploadImage({
    required BuildContext context,
    required ImageSource imageSource,
    required String type,
  }) {
    return sl<ContentCreatorRemoteData>().uploadImage(
      context: context,
      imageSource: imageSource,
      type: type,
    );
  }

  @override
  Future<(bool, String?)> createPost({
    required CreatePostModel createPostModel,
    required String userId,
  }) {
    return sl<ContentCreatorRemoteData>().createPost(
      createPostModel: createPostModel,
      userId: userId,
    );
  }
}
