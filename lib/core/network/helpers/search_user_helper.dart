import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/core/models/user_model.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/service_locator.dart';

class SearchUserHelper {
  
  // @ -- Search User --
  Future<(bool success, List<UserEntity>? users, String? message)>
  searchUserByUsername({
    required String path,
    required String userId,
  }) async {
    try {
      final response = await sl<ApiService>().get(
        path: path,
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;

        if (response.statusCode == 200) {
          final users =
              (responseData["users"] as List)
                  .map((userJson) => UserModel.fromJson(userJson).toEntity())
                  .toList();
          return (true, users, "Users found successfully.");
        } else {
          return (
            false,
            null,
            responseData["message"]?.toString() ?? "Failed to fetch users.",
          );
        }
      } else {
        return (
          false,
          null,
          "No response from server. Please try again later.",
        );
      }
    } catch (e) {
      return (false, null, "Unexpected error occurred: ${e.toString()}");
    }
  }
}
