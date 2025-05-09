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
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_image_editor/core/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/features/main_editor/main_editor.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/service_locator.dart';

class ServicesUtils {
  static bool emailValidator(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static Future<void> saveTokenId(String tokenId) async {
    final secureStorage = sl<FlutterSecureStorage>();

    await secureStorage.write(
      key: MyStrings.secureStorageToken,
      value: tokenId,
    );
  }

  static Future<String?> getTokenId() async {
    final secureStorage = sl<FlutterSecureStorage>();

    return await secureStorage.read(key: MyStrings.secureStorageToken);
  }

  static Future<XFile?> pickImage(
    ImageSource imageSource,
    BuildContext context,
  ) async {
    final file = await sl<ImagePicker>().pickImage(source: imageSource);

    if (file != null) {
      if (context.mounted) {
        Navigator.pop(context);
        return file;
      }
      return null;
    }
    return null;
  }

  static Future<File?> editImage(File file) async {
    File? editedFile;

    ProImageEditor.file(
      file,
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (Uint8List bytes) async {
          final tempDir = await getTemporaryDirectory();
          final fileName = const Uuid().v4();
          final newFile = File('${tempDir.path}/$fileName.jpg');

          editedFile = await newFile.writeAsBytes(bytes);
        },
      ),
    );

    return editedFile;
  }

  Future<(bool success, String message, CloudImageEntity? cloudImage)>
  uploadToCloud(String type, File file, int maxBytes) async {
    try {
      final fileLength = await file.length();
      if (fileLength > maxBytes) {
        return (
          false,
          "Image size too large. Maximum ${maxBytes.toString().substring(1)}MB allowed.",
          null,
        );
      }

      final response = await sl<ApiService>().post(
        path: MyStrings.cloudinaryUrl,
        body: FormData.fromMap({
          'file': await MultipartFile.fromFile(file.path),
          'upload_preset': MyKeys.cloudinaryPresetName,
        }),
      );
      if (response != null) {
        final responseData = response.data;
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

  Future<File?> compressAndGetFile(File file) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = path.join(tempDir.path, path.basename(file.path));
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
    );
    if (result != null) {
      return File(result.path);
    }
  }
}
