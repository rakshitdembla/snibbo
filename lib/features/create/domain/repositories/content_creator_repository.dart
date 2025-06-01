import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snibbo_app/features/create/data/models/create_post_model.dart';
import 'package:snibbo_app/features/create/data/models/create_story_model.dart';

abstract class ContentCreatorRepository {
  Future<(bool success, String? message, String? fileUrl)> uploadImage({
    required BuildContext context,
    required ImageSource imageSource,
    required String type,
  });

    Future<(bool success, String? message)> createStory({
    required CreateStoryModel createStoryModel,
    required String userId,
  });

    Future<(bool success, String? message)> createPost({
    required CreatePostModel createPostModel,
    required String userId,
  }) ;
}
