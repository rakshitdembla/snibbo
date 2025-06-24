import 'package:snibbo_app/core/entities/user_entity.dart';
import 'package:snibbo_app/features/user/data/data_sources/remote/user_remote_data.dart';
import 'package:snibbo_app/service_locator.dart';

class SearchFollowingUsecase {

Future<(bool success, List<UserEntity>? users, String? message)>
call({
  required String username,
  required String userId,
  required String userToSearch,
}) {
  return sl<UserRemoteData>().searchFollowing(
    username: username,
    userId: userId,
    userToSearch: userToSearch,
  );
}
}

