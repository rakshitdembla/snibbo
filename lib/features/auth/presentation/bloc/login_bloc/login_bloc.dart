import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/auth/data/models/login_req_model.dart';
import 'package:snibbo_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/login_bloc/login_events.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/login_bloc/login_states.dart';
import 'package:snibbo_app/service_locator.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginInitialState()) {
    on<Login>((event, emit) async {
      emit(LoginLoadingState());
      final String email = event.email;
      final String password = event.password;

      if (email.isEmpty || password.isEmpty) {
        emit(
          LoginErrorState(
            title: "Missing Information",
            description: "Please fill both email & password fields.",
          ),
        );
        return;
      }

      bool validateEmail = ServicesUtils.emailValidator(email);

      if (!validateEmail) {
        emit(
          LoginErrorState(
            title: "Invalid Email",
            description: "Please enter a valid email address.",
          ),
        );
        return;
      }

      if (password.length < 8) {
        emit(
          LoginErrorState(
            title: "Weak Password",
            description: "Password should be at least 8 characters long.",
          ),
        );
        return;
      }

      final (success, tokenId,username, message) = await sl<LoginUsecase>().call(
        LoginReqModel(email: email, password: password),
      );

      if (success && tokenId != null && tokenId.isNotEmpty && username != null && username.isNotEmpty) {
        debugPrint("token id is $tokenId");
        debugPrint("username is $username");
        
        await ServicesUtils.saveTokenId(tokenId);
        await ServicesUtils.saveUsername(username);
        emit(
          LoginSuccessState(
            title: "Login Successful",
            description: message ?? "You have successfully logged in.",
          ),
        );
        return;
      }

      emit(
        LoginErrorState(
          title: "Login Failed",
          description:
              message ?? "An error occurred during login. Please try again.",
        ),
      );
    });
  }
}
