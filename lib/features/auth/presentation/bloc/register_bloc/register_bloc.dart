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

      // Name validation
      if (name.length < 2) {
        emit(
          RegisterErrorState(
            title: "Name Too Short",
            description: "Name must be at least 2 characters long.",
          ),
        );
        return;
      } else if (name.length > 30) {
        emit(
          RegisterErrorState(
            title: "Name Too Long",
            description: "Name must not exceed 30 characters.",
          ),
        );
        return;
      } else if (!ServicesUtils.nameValidator(name)) {
        emit(
          RegisterErrorState(
            title: "Invalid Name",
            description: "Name cannot contain numbers or special characters.",
          ),
        );
        return;
      }

      // Username validation
      if (username.length < 4) {
        emit(
          RegisterErrorState(
            title: "Username Too Short",
            description: "Username must be at least 4 characters long.",
          ),
        );
        return;
      } else if (username.length > 20) {
        emit(
          RegisterErrorState(
            title: "Username Too Long",
            description: "Username must not exceed 20 characters.",
          ),
        );
        return;
      } else if (!ServicesUtils.usernameValidator(username)) {
        emit(
          RegisterErrorState(
            title: "Invalid Username",
            description:
                "Username cannot contain spaces or special characters.",
          ),
        );
        return;
      }

      // Email validation
      if (email.length > 64) {
        emit(
          RegisterErrorState(
            title: "Email Too Long",
            description: "Email must not exceed 64 characters.",
          ),
        );
        return;
      } else if (!ServicesUtils.emailValidator(email)) {
        emit(
          RegisterErrorState(
            title: "Invalid Email",
            description:
                "Please enter a valid email address (e.g., user@example.com).",
          ),
        );
        return;
      }

      // Password validation
      if (password.length < 8) {
        emit(
          RegisterErrorState(
            title: "Password Too Short",
            description: "Password must be at least 8 characters long.",
          ),
        );
        return;
      } else if (password.length > 30) {
        emit(
          RegisterErrorState(
            title: "Password Too Long",
            description: "Password must not exceed 30 characters.",
          ),
        );
        return;
      } else if (!ServicesUtils.passwordValidator(password)) {
        emit(
          RegisterErrorState(
            title: "Weak Password",
            description:
                "Password must contain a letter, a number, a special character, and should not have spaces at the start or end.",
          ),
        );
        return;
      }

      final (
        success,
        tokenId,
        resUsername,
        message,
      ) = await sl<RegisterUsecase>().call(
        RegisterReqModel(
          email: email,
          password: password,
          name: name,
          username: username,
        ),
      );

      if (success &&
          tokenId != null &&
          tokenId.isNotEmpty &&
          resUsername != null &&
          resUsername.isNotEmpty) {
        debugPrint("token id is $tokenId");
        debugPrint("username is $resUsername");
        await ServicesUtils.saveTokenId(tokenId);
        await ServicesUtils.saveUsername(resUsername);
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
