import 'package:snibbo_app/features/profile/data/models/update_profile_req_model.dart';
import 'package:snibbo_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class UpdateProfileUsecase {
  Future<(bool success, String? message)> call({
    required String userId,
    required UpdateProfileReqModel updateProfileReqModel,
  }) {
    return sl<ProfileRepository>().updateProfile(
      userId: userId,
      updateProfileReqModel: updateProfileReqModel,
    );
  }
}
