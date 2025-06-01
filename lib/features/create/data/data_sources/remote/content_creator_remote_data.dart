import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/create/data/models/create_post_model.dart';
import 'package:snibbo_app/features/create/data/models/create_story_model.dart';
import 'package:snibbo_app/service_locator.dart';

class ContentCreatorRemoteData {
  Future<(bool success, String? message, String? fileUrl)> uploadImage({
    required BuildContext context,
    required ImageSource imageSource,
    required String type,
  }) async {
    File? editedFile;

    try {
      //@Pick Image -->
      final XFile? xfile = await ServicesUtils.pickImage(imageSource, context);

      if (xfile == null) {
        return (false, "$type selection was cancelled or failed.", null);
      }

      //@ImageSize Validation -->
      final File file = File(xfile.path);

      final fileLength = await file.length();
      if (fileLength > 2000000) {
        return (false, "Image size too large. Maximum 2MB allowed.", null);
      }

      //@Edit Image -->
      if (context.mounted) {
        editedFile = await ServicesUtils.editImage(
          context: context,
          file: file,
        );
      }

      if (editedFile == null) {
        return (false, "$type editing was cancelled or failed.", null);
      }

      //@Compress Image -->
      final compressedFile = await ServicesUtils.compressAndGetFile(editedFile);

      if (compressedFile == null) {
        return (false, "Oops! Something went wrong.", null);
      }

      //@Upload To Cloud -->

      final (
        success,
        message,
        cloudImageEntity,
      ) = await ServicesUtils.uploadToCloud(type, compressedFile);

      if (success && cloudImageEntity != null) {
        return (true, message, cloudImageEntity.secureUrl);
      } else {
        return (false, message, null);
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}", null);
    }
  }

  Future<(bool success, String? message)> createStory({
    required CreateStoryModel createStoryModel,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: ApiRoutes.createStory,
        headers: {MyStrings.userIdHeader: userId},
        body: createStoryModel.toJson(),
      );

      if (response != null) {
        final responseData = await response.data;

        if (response.statusCode == 201) {
          return (true, "Story uploaded successfully.");
        } else {
          return (false, responseData["message"].toString());
        }
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }

  Future<(bool success, String? message)> createPost({
    required CreatePostModel createPostModel,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: ApiRoutes.createPost,
        headers: {MyStrings.userIdHeader: userId},
        body: createPostModel.toJson(),
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 201) {
          return (true, "Post uploaded successfully.");
        } else {
          return (false, responseData["message"].toString());
        }
      } else {
        return (false, "No response from server. Please try again later.");
      }
    } catch (e) {
      return (false, "Unexpected error occurred: ${e.toString()}");
    }
  }
}
