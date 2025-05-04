import "package:get_it/get_it.dart";
import "package:snibbo_app/core/network/base_api/api_services.dart";
import "package:snibbo_app/features/auth/data/data_sources/remote/auth_remote_data.dart";
import "package:snibbo_app/features/auth/data/repositories/auth_repository_impl.dart";
import "package:snibbo_app/features/auth/domain/repositories/auth_repository.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:snibbo_app/features/auth/domain/usecases/forget_password_usecase.dart";
import "package:snibbo_app/features/auth/domain/usecases/login_usecase.dart";
import "package:snibbo_app/features/auth/domain/usecases/register_usecase.dart";

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<ApiService>(ApiService());
  sl.registerSingleton<AuthRemoteData>(AuthRemoteData());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  sl.registerSingleton<LoginUsecase>(
    LoginUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerSingleton<RegisterUsecase>(
    RegisterUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerSingleton<ForgetPasswordUsecase>(
    ForgetPasswordUsecase(authRepository: sl<AuthRepository>()),
  );
}
