import 'package:snibbo_app/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUsecase {
  final AuthRepository authRepository;

  ForgetPasswordUsecase({required this.authRepository});

  Future<(bool success, String? message)> call(String email) {
    return authRepository.forgetPassword(email);
  }
}
