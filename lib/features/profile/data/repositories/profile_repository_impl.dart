import 'package:snibbo_app/features/profile/data/data_sources/remote/profile_remote_data.dart';
import 'package:snibbo_app/features/profile/data/models/update_profile_req_model.dart';
import 'package:snibbo_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<(bool, String?)> updateProfile({
    required String userId,
    required UpdateProfileReqModel updateProfileReqModel,
  }) {
    return sl<ProfileRemoteData>().updateProfile(
      userId: userId,
      updateProfileReqModel: updateProfileReqModel,
    );
  }

}
