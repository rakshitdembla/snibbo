import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/profile/data/models/update_profile_req_model.dart';
import 'package:snibbo_app/service_locator.dart';
import '../../../../../core/constants/mystrings.dart';

class ProfileRemoteData {
  Future<(bool success, String? message)> updateProfile({
    required String userId,
    required UpdateProfileReqModel updateProfileReqModel,
  }) async {
    try {
      final response = await sl<ApiService>().patch(
        path: ApiRoutes.updateProfile,
        headers: {MyStrings.userIdHeader: userId},
        body: updateProfileReqModel.toJson()
      );

      if (response != null) {
        final responseData = response.data;
        if (response.statusCode == 201) {
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
}
