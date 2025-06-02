import 'package:snibbo_app/features/profile/data/models/update_profile_req_model.dart';

abstract class ProfileRepository {
  Future<(bool success, String? message)> updateProfile({
    required String userId,
    required UpdateProfileReqModel updateProfileReqModel,
  });
}
