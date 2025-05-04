import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/auth/data/models/register_req_model.dart';
import 'package:snibbo_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/register_bloc/register_events.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/register_bloc/register_states.dart';
import 'package:snibbo_app/service_locator.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(RegisterInitialState()) {
    on<Register>((event, emit) async {
      emit(RegisterLoadingState());

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
            title: "Missing Information",
            description: "All fields are required to register.",
          ),
        );

        return;
      }

      if (username.length < 4) {
        emit(
          RegisterErrorState(
            title: "Username Too Short",
            description: "Username must be at least 4 characters long.",
          ),
        );
        return;
      }

      bool validateEmail = ServicesUtils.emailValidator(email);

      if (!validateEmail) {
        emit(
          RegisterErrorState(
            title: "Invalid Email",
            description:
                "Please enter a valid email address (e.g., user@example.com).",
          ),
        );
        return;
      }

      if (password.length < 8) {
        emit(
          RegisterErrorState(
            title: "Password Too Short",
            description: "For security, please use at least 8 characters.",
          ),
        );
        return;
      }

      final (success, tokenId, message) = await sl<RegisterUsecase>().call(
        RegisterReqModel(
          email: email,
          password: password,
          name: name,
          username: username,
        ),
      );

      if (success && tokenId != null && tokenId.isNotEmpty) {
        debugPrint("token id is $tokenId");
        await ServicesUtils.saveTokenId(tokenId);
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
