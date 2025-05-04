import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/auth/data/models/register_req_model.dart';
import 'package:snibbo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/register_bloc/register_events.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/register_bloc/register_states.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  final AuthRepository authRepository;
  RegisterBloc({required this.authRepository}) : super(RegisterInitialState()) {
    on<Register>((event, emit) async {
      emit(RegisterInitialState());

      final String email = event.email;
      final String password = event.password;
      final String username = event.username;
      final String name = event.name;

      if (email.isEmpty ||
          password.isEmpty ||
          username.isEmpty ||
          name.isEmpty) {
        emit(
          RegisterErrorState(
            title: "Missingf info",
            description: "All fields are mandatory",
          ),
        );

        return;
      }

      bool validateEmail = ServicesUtils.emailValidator(email);

      if (!validateEmail) {
        emit(
          RegisterErrorState(
            title: "Invalid Email",
            description: "Please enter a valid email address.",
          ),
        );
        return;
      }

      if (password.length < 8) {
        emit(
          RegisterErrorState(
            title: "Weak Password",
            description: "Password should be at least 8 characters long.",
          ),
        );
        return;
      }

      if (username.length < 4) {
        emit(
          RegisterErrorState(
            title: "Invalid Username",
            description: "Password should be at least 8 characters long.",
          ),
        );
        return;
      }

      final (success, tokenId, message) = await authRepository.registerUser(
        RegisterReqModel(
          email: email,
          password: password,
          name: name,
          username: username,
        ),
      );

      if (success) {
        await ServicesUtils.saveTokenId(tokenId!);
        emit(
          RegisterSuccessState(
            title: "Register Successful",
            description: message ?? "You have successfully registered in.",
          ),
        );
        return;
      }

      emit(
        RegisterErrorState(
          title: "Register Failed",
          description:
              message ?? "An error occurred during login. Please try again.",
        ),
      );
    });
  }
}
