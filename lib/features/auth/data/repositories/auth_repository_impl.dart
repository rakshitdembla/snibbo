import 'package:snibbo_app/features/auth/data/data_sources/remote/auth_remote_data.dart';
import 'package:snibbo_app/features/auth/data/models/login_req_model.dart';
import 'package:snibbo_app/features/auth/data/models/register_req_model.dart';
import 'package:snibbo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:snibbo_app/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<(bool, String?, String?)> loginUser(LoginReqModel loginReqModel) {
    return sl<AuthRemoteData>().loginUser(loginReqModel);
  }
  
  @override
  Future<(bool, String?, String?)> registerUser(RegisterReqModel registerReqModel) {
    return sl<AuthRemoteData>().registerUser(registerReqModel);
  
  }
  
  @override
  Future<(bool, String?)> forgetPassword(String email) {
    return sl<AuthRemoteData>().forgetPassword(email);
  }
}