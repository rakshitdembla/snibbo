import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widget/elevated_cta.dart';
import 'package:snibbo_app/core/widget/text_field.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';
import '../../../../core/theme/mycolors.dart';
import '../../../../core/widget/text_span_bottom.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final FocusNode usernameNode = FocusNode();
  final FocusNode nameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    usernameController.dispose();
    nameController.dispose();

    passNode.dispose();
    emailNode.dispose();
    nameNode.dispose();
    usernameNode.dispose();
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
                hintText: MyStrings.nameHintText,
                label: "Name",
                focusNode: nameNode,
                isPassword: true,
                textEditingController: nameController,
                maxLength: 30,
                maxLines: 1,
                onSubmit: (String value) {},
                prefixIcon: Icons.person
              ),
              SizedBox(height: height * 0.02),
              MyTextField(
                hintText: MyStrings.usernameHintText,
                label: "Username",
                focusNode: usernameNode,
                isPassword: true,
                textEditingController: usernameController,
                maxLength: 20,
                maxLines: 1,
                onSubmit: (String value) {},
                prefixIcon: 
                  Icons.alternate_email,
                
              ),
              SizedBox(height: height * 0.02),

              MyTextField(
                hintText: MyStrings.emailHintText,
                label: "Email",
                focusNode: emailNode,
                isPassword: false,
                textEditingController: emailController,
                maxLength: 64,
                maxLines: 1,
                onSubmit: (String value) {},
                prefixIcon:
                  Icons.email_rounded,
                
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
                prefixIcon: Icons.lock
              ),

              SizedBox(height: height * 0.040),
              ElevatedCTA(onPressed: () {}, buttonName: "Sign Up"),
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
              actionTitle: "Log In",
              onTap: () {
                context.router.push(LoginScreenRoute());
              },
              title: "Already have an account? ",
            ),
          ],
        ),
      ),
    );
  }
}
