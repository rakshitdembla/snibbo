import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:snibbo_app/core/constants/my_keys.dart';
import 'package:snibbo_app/core/entities/cloud_image_entity.dart';
import 'package:snibbo_app/core/models/cloud_image_model.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_image_editor/core/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/features/main_editor/main_editor.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/service_locator.dart';

class ServicesUtils {
  // @Email Validator Helper
  static bool emailValidator(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // @Save User TokenId Helper
  static Future<void> saveTokenId(String tokenId) async {
    final secureStorage = sl<FlutterSecureStorage>();

    await secureStorage.write(
      key: MyStrings.secureStorageToken,
      value: tokenId,
    );
  }

  // @Get User TokenId Helper
  static Future<String?> getTokenId() async {
    final secureStorage = sl<FlutterSecureStorage>();

    return await secureStorage.read(key: MyStrings.secureStorageToken);
  }

  //@ DateTime to TimeAgo Format Helper

  static String toTimeAgo(DateTime dateTime) {
    return timeago.format(dateTime);
  }

  // @Image Picker Helper
  static Future<XFile?> pickImage(
    ImageSource imageSource,
    BuildContext context,
  ) async {
    final file = await sl<ImagePicker>().pickImage(source: imageSource);

    if (file != null) {
      debugPrint("Picked File ${file}");
      return file;
    }
    return null;
  }

  // @Image Editor Helper
  static Future<File?> editImage({
    required BuildContext context,
    required File file,
  }) async {
    File? editedFile;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProImageEditor.file(
              file,
              callbacks: ProImageEditorCallbacks(
                onImageEditingComplete: (Uint8List bytes) async {
                  final tempDir = await getTemporaryDirectory();
                  final fileName = const Uuid().v4();
                  final newFile = File('${tempDir.path}/$fileName.jpg');

                  final writtenFile = await newFile.writeAsBytes(bytes);
                  editedFile = writtenFile;

                  debugPrint("Image editing completes.${file.toString()}");
                },
                onCloseEditor: (editorMode) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    debugPrint("Image editing closes. ${file.toString()}");
                  }
                },
              ),
            ),
      ),
    );
    return editedFile;
  }

  // @Image Compressor Helper
  static Future<File?> compressAndGetFile(File file) async {
    // create target path for compressed image
    final tempDir = await getTemporaryDirectory();
    final uniqueId = const Uuid().v4();
    final targetDirPath = path.join(tempDir.path, uniqueId);
    final targetPath = path.join(targetDirPath, path.basename(file.path));

    try {
      final dir = Directory(targetDirPath);
      if (!(await dir.exists())) {
        await dir.create(recursive: true);
      }

      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 80,
      );
      return result != null ? File(result.path) : null;
    } catch (e) {
      return null;
    }
  }

  // @Cloudinary Uploader Helper
  static Future<(bool success, String? message, CloudImageEntity? cloudImage)>
  uploadToCloud(String type, File file) async {
    try {
      final response = await sl<ApiService>().post(
        path: MyStrings.cloudinaryUrl,
        body: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
          'upload_preset': MyKeys.cloudinaryPresetName,
        }),
      );
      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          return (
            true,
            "$type uploaded successfully.",
            CloudImageModel.fromJson(responseData).toEntity(),
          );
        } else {
          return (
            false,
            responseData["error"]?["message"] as String? ??
                "Something went wrong.",
            null,
          );
        }
      } else {
        return (false, "Something went wrong.", null);
      }
    } catch (e) {
      return (false, e.toString(), null);
    }
  }
}
