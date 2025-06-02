import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/user/data/models/profile_model.dart';
import 'package:snibbo_app/features/user/domain/entities/profile_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class UserRemoteData {
  Future<(bool success, String? message)> followUser({
    required String userId,
    required String username,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.followUser}/$username",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 202) {
          return (true, responseData["message"].toString());
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

  Future<(bool success, String? message)> unfollowUser({
    required String userId,
    required String username,
  }) async {
    try {
      final response = await sl<ApiService>().post(
        path: "${ApiRoutes.unfollowUser}/$username",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 202) {
          return (true, responseData["message"].toString());
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

  Future<(bool success, ProfileEntity? profileEntity, String? message)>
  getUserProfile({required String username,required String userId}) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.userProfile}/$username",
        headers: {MyStrings.userIdHeader: userId},
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 200) {
          return (
            true,
            ProfileModel.fromJson(responseData["user"]).toEntity(),
            responseData["message"].toString(),
          );
        } else {
          return (false, null, responseData["message"].toString());
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
