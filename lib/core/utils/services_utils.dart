import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
}
