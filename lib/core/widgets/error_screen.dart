import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class ErrorScreen extends StatelessWidget {
  final bool isFeedError;
  const ErrorScreen({super.key, required this.isFeedError});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final extraH = isFeedError ? height * 0.05 : 0;
    return SafeArea(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height:
              height -
              UiUtils.bottomNavBar(context: context) -
              kToolbarHeight -
              height * 0.09 -
              extraH,
          child: Center(
            child: Center(
              child: Lottie.asset(MyAssets.cat404, height: height * 0.15),
            ),
          ),
        ),
      ),
    );
  }
}
