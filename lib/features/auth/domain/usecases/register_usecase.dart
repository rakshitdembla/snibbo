import 'package:snibbo_app/features/auth/data/models/register_req_model.dart';
import 'package:snibbo_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  Future<(bool success, String? tokenId,String? username, String? message)> call(
    RegisterReqModel registerReqModel,
  ) {
    return authRepository.registerUser(registerReqModel);
  }
}
