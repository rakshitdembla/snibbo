import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snibbo_app/features/create/domain/repositories/content_creator_repository.dart';

class UploadImageUsecase {
  final ContentCreatorRepository contentCreatorRepository;

  UploadImageUsecase({required this.contentCreatorRepository});
  Future<(bool success, String? message, String? fileUrl)> call({
    required BuildContext context,
    required ImageSource imageSource,
    required String type,
  }) {
    return contentCreatorRepository.uploadImage(
      context: context,
      imageSource: imageSource,
      type: type,
    );
  }
}
