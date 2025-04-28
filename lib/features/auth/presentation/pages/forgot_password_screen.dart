import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/elevated_cta.dart';
import 'package:snibbo_app/core/widgets/h1_h2_title.dart';
import 'package:snibbo_app/core/widgets/text_field.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FocusNode emailNode = FocusNode();
  final TextEditingController emailController = TextEditingController();

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
              ElevatedCTA(
                onPressed: () {},
                buttonName: "Send Reset Link",
                isShort: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
