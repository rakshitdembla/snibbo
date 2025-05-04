import 'package:snibbo_app/features/auth/data/models/login_req_model.dart';
import 'package:snibbo_app/features/auth/data/models/register_req_model.dart';

abstract class AuthRepository {
  Future<(bool success, String? tokenId, String? message)> loginUser(
    LoginReqModel loginReqModel,
  );

  Future<(bool success, String? tokenId, String? message)> registerUser(
    RegisterReqModel registerReqModel,
  );

  Future<(bool success, String? message)> forgetPassword(
    String email
  );
}
