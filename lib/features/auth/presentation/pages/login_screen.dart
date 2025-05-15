import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/core/widgets/text_field.dart';
import 'package:snibbo_app/features/auth/presentation/widgets/text_span_bottom.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/login_bloc/login_events.dart';
import 'package:snibbo_app/features/auth/presentation/bloc/login_bloc/login_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

import '../../../../core/constants/myassets.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode emailNode = FocusNode();
  final TextEditingController emailController = TextEditingController();

  final FocusNode passNode = FocusNode();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    emailNode.dispose();
    passController.dispose();
    passNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: MyColors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: width * 0.030, right: width * 0.030),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.07),
                child: Image.asset(
                  MyAssets.logoBig,
                  height: height * 0.11,
                  fit: BoxFit.contain,
                ),
              ),
              MyTextField(
                hintText: MyStrings.emailHintText,
                label: "Email",
                focusNode: emailNode,
                isPassword: false,
                textEditingController: emailController,
                maxLength: 64,
                maxLines: 1,
                onSubmit: (String value) {},
                prefixIcon: Icons.email_rounded,
              ),
              SizedBox(height: height * 0.02),
              MyTextField(
                hintText: MyStrings.passwordHintText,
                label: "Password",
                focusNode: passNode,
                isPassword: true,
                textEditingController: passController,
                maxLength: 32,
                maxLines: 1,
                onSubmit: (String value) {},
                prefixIcon: Icons.lock,
              ),
              SizedBox(height: height * 0.0070),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    context.router.push(ForgotPasswordScreenRoute());
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: MyColors.secondary,
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.040),
              BlocConsumer<LoginBloc, LoginStates>(
                listener: (context, state) {
                  if (state is LoginErrorState) {
                    UiUtils.showToast(
                      title: state.title,
                      isDark: isDark,
                      description: state.description,
                      context: context,
                      isSuccess: false,
                      isWarning: false,
                    );
                  } else if (state is LoginSuccessState) {
                    UiUtils.showToast(
                      title: state.title,
                      isDark: isDark,
                      description: state.description,
                      context: context,
                      isSuccess: true,
                      isWarning: false,
                    );
                    context.router.push(GeneralPageRoute());
                  }
                },
                builder: (context, state) {
                  return state is LoginLoadingState
                      ? Center(child: CircularProgressLoading())
                      : ElevatedCTA(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                            Login(
                              email: emailController.text.trim(),
                              password: passController.text,
                            ),
                          );
                        },
                        buttonName: "Log In",
                        isShort: false,
                      );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextSpanBottom(
              actionTitle: "Sign Up",
              onTap: () {
                context.router.push(RegisterScreenRoute());
              },
              title: "Don't have an account? ",
            ),
          ],
        ),
      ),
    );
  }
}
