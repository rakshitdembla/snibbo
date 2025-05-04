import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/core/widgets/h1_h2_title.dart';
import 'package:snibbo_app/core/widgets/text_field.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/forget_password_bloc/forget_pass_bloc.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/forget_password_bloc/forget_pass_events.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/forget_password_bloc/forget_pass_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FocusNode emailNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  late bool isDark;
  bool showedInitialToast = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!showedInitialToast) {
         isDark = context.read<ThemeBloc>().state is DarkThemeState;
        UiUtils.showToast(
          title: "Beta Feature Notice",
          description:
              "The password reset is functional but may experience occasional issues. "
              "If you encounter problems, please try again later or contact support.",
          context: context,
          isWarning: true,
          isDark: isDark,
          isSuccess: false,
        );

        showedInitialToast = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: MyColors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: width * 0.030,
            right: width * 0.030,
            top: height * 0.0050,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: H1H2Title(
                  h1: MyStrings.forgotPasswordH1,
                  h2: MyStrings.forgotPasswordH2,
                ),
              ),
              SizedBox(height: height * 0.040),
              MyTextField(
                hintText: MyStrings.forgotPassHint,
                label: "Email",
                focusNode: emailNode,
                isPassword: false,
                textEditingController: emailController,
                maxLength: 64,
                maxLines: 1,
                onSubmit: (String value) {},
                prefixIcon: Icons.email_rounded,
              ),
              SizedBox(height: height * 0.040),
              BlocConsumer<ForgetPassBloc, ForgetPassStates>(
                listener: (context, state) {
                  if (state is ForgetPassErrorState) {
                    UiUtils.showToast(
                      title: state.title,
                      isDark: isDark,
                      description: state.description,
                      context: context,
                      isSuccess: false,
                      isWarning: false,
                    );
                  } else if (state is ForgetPassSuccessState) {
                    UiUtils.showToast(
                      title: state.title,
                      isDark: isDark,
                      description: state.description,
                      context: context,
                      isSuccess: true,
                      isWarning: false,
                    );

                    context.router.pop();
                  }
                },
                builder: (context, state) {
                  return state is ForgetPassLoadingState
                      ? CircularProgressLoading()
                      : ElevatedCTA(
                        onPressed: () {
                          context.read<ForgetPassBloc>().add(
                            ForgetPassword(email: emailController.text.trim()),
                          );
                        },
                        buttonName: "Send Reset Link",
                        isShort: false,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
