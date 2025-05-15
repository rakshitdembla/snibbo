import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/auth/data/models/login_req_model.dart';
import 'package:snibbo_app/features/auth/data/models/register_req_model.dart';
import 'package:snibbo_app/service_locator.dart';

class AuthRemoteData {
  Future<(bool success, String? tokenId, String? message)> loginUser(
    LoginReqModel loginReqModel,
  ) async {
    try {
      final response = await sl<ApiService>().post(
        path: ApiRoutes.login,
        body: loginReqModel.toJson(),
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          final tokenId = responseData["user"]?["_id"];
          return (
            true,
            tokenId == null ? null : responseData["user"]?["_id"].toString(),
            tokenId == null
                ? "Login failed: Missing user ID in response. Please try again."
                : responseData["message"].toString(),
          );
        } else {
          return (false, null, responseData["message"].toString());
        }
      } else {
        return (false, null, "Something went wrong, please try again later.");
      }
    } catch (e) {
      return (false, null, e.toString());
    }
  }

  Future<(bool success, String? message)> forgetPassword(String email) async {
    try {
      final response = await sl<ApiService>().post(
        path: ApiRoutes.forgetPassword,
        body: {"email": email},
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          return (true, responseData["message"].toString());
        } else {
          return (false, responseData["message"].toString());
        }
      } else {
        return (false, "Something went wrong, please try again later.");
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  Future<(bool success, String? tokenId, String? message)> registerUser(
    RegisterReqModel registerReqModel,
  ) async {
    try {
      final response = await sl<ApiService>().post(
        path: ApiRoutes.register,
        body: registerReqModel.toJson(),
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 201) {
          final tokenId = responseData["user"]?["_id"];
          return (
            true,
            tokenId == null ? null : responseData["user"]?["_id"].toString(),
            tokenId == null
                ? "Register failed: Missing user ID in response. Please try again."
                : responseData["message"].toString(),
          );
        } else {
          return (false, null, responseData["message"].toString());
        }
      } else {
        return (false, null, "Something went wrong, please try again later.");
      }
    } catch (e) {
      return (false, null, e.toString());
    }
  }
}
