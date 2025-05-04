import 'package:snibbo_app/features/auth/data/models/login_req_model.dart';
import 'package:snibbo_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<(bool success, String? tokenId, String? message)> call(
    LoginReqModel loginReqModel,
  ) {
    return authRepository.loginUser(loginReqModel);
  }
}
