import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/constants/my_keys.dart';
import 'package:snibbo_app/core/entities/cloud_image_entity.dart';
import 'package:snibbo_app/core/models/cloud_image_model.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_image_editor/core/models/editor_callbacks/pro_image_editor_callbacks.dart';
import 'package:pro_image_editor/features/main_editor/main_editor.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesUtils {
  // @Email Validator Helper
  static bool emailValidator(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // @Username Validator Helper
  static bool usernameValidator(String username) {
    final usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$');
    return usernameRegex.hasMatch(username);
  }

  // @Name Validator Helper
  static bool nameValidator(String name) {
    final nameRegex = RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)*$');
    return nameRegex.hasMatch(name);
  }

  // @Password Validator Helper
  static bool passwordValidator(String password) {
    // Reject if password starts or ends with a space
    if (password.startsWith(' ') || password.endsWith(' ')) return false;

    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$&*~]).+$');
    return passwordRegex.hasMatch(password);
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

  // @Delete User TokenId Helper
  static Future<void> deleteTokenId() async {
    final secureStorage = sl<FlutterSecureStorage>();

    await secureStorage.delete(key: MyStrings.secureStorageToken);
  }

  // @Save User Username Helper
  static Future<void> saveUsername(String username) async {
    final secureStorage = sl<FlutterSecureStorage>();

    await secureStorage.write(
      key: MyStrings.secureStorageUsername,
      value: username,
    );
  }

  // @Delete User Username Helper
  static Future<void> deleteUsername() async {
    final secureStorage = sl<FlutterSecureStorage>();

    await secureStorage.delete(key: MyStrings.secureStorageUsername);
  }

  // @Get User TokenId Helper
  static Future<String?> getUsername() async {
    final secureStorage = sl<FlutterSecureStorage>();

    return await secureStorage.read(key: MyStrings.secureStorageUsername);
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
      debugPrint("Picked File $file");
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
    await PersistentNavBarNavigator.pushNewScreen(
      context,
      withNavBar: false,
      screen: ProImageEditor.file(
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
              Navigator.of(context, rootNavigator: true).pop();
              debugPrint("Image editing closes. ${file.toString()}");
            }
          },
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

  //Conditional DateFormat
  static String formattedDate(DateTime? date) {
    if (date == null) {
      return "";
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    final difference = today.difference(messageDate).inDays;
    debugPrint("${difference.toString()},$now,$today,$date");

    if (difference == 0) {
      return DateFormat('HH:mm').format(date);
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return DateFormat('EEE').format(date);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static Future<void> openEmailApp({
    required bool isReport,
    String? reportFor,
    String? uniqueID,
    String? text,
    required BuildContext context,
  }) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map(
            (MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
          )
          .join('&');
    }

    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final Uri emailLaunchUri = Uri(
      scheme: "mailto",
      path: "app.snibbo@gmail.com",
      query: encodeQueryParameters(<String, String>{
        'subject': isReport ? 'Report for $reportFor - $uniqueID ' : text ?? "",
        'body': '',
      }),
    );
    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      if (context.mounted) {
        UiUtils.showToast(
          title: "Couldn't open your mail app.",
          isDark: isDark,
          description: e.toString(),
          context: context,
          isSuccess: false,
          isWarning: false,
        );
      }
    }
  }

  static void copyLink({
    required String uniqueID,
    required String type,
    required BuildContext context,
  }) async {
    final link = "https://www.snibbo.com/?type=$type&uniqueId=$uniqueID";
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;

    try {
      await Clipboard.setData(ClipboardData(text: link));

      if (context.mounted) {
        UiUtils.showToast(
          title: "Link Copied!",
          description: "The $type link has been copied to clipboard.",
          context: context,
          isDark: isDark,
          isSuccess: true,
          isWarning: false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        UiUtils.showToast(
          title: "Failed to copy link",
          isDark: isDark,
          description: e.toString(),
          context: context,
          isSuccess: false,
          isWarning: false,
        );
      }
    }
  }
}
