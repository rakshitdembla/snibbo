import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/forget_password_bloc/forget_pass_events.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/forget_password_bloc/forget_pass_states.dart';
import 'package:snibbo_app/service_locator.dart';

class ForgetPassBloc extends Bloc<ForgetPassEvents, ForgetPassStates> {
  ForgetPassBloc() : super(ForgetPassInitialState()) {
    on<ForgetPassword>((event, emit) async {
      emit(ForgetPassLoadingState());

      final email = event.email;

      if (email.isEmpty) {
        emit(
          ForgetPassErrorState(
            title: "Email Required",
            description: "Please enter your email address to continue.",
          ),
        );
        return;
      }
      final validateEmail = ServicesUtils.emailValidator(email);

      if (!validateEmail) {
        emit(
          ForgetPassErrorState(
            title: "Invalid Email",
            description:
                "Please enter a valid email address (e.g., user@example.com).",
          ),
        );
        return;
      }

      final (success, message) = await sl<ForgetPasswordUsecase>().call(email);

      if (success) {
        emit(
          ForgetPassSuccessState(
            title: "Reset Email Sent",
            description:
                message ??
                "We've sent a password reset link to your email. Please check your inbox.",
          ),
        );
        return;
      }

      emit(
        ForgetPassErrorState(
          title: "Password Reset Failed",
          description:
              message ??
              "We couldn't process your request. Please try again later.",
        ),
      );
    });
  }
}
