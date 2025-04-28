import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';

class CircularProgressLoading extends StatefulWidget {
  const CircularProgressLoading({super.key});

  @override
  State<CircularProgressLoading> createState() =>
      _CircularProgressLoadingState();
}

class _CircularProgressLoadingState extends State<CircularProgressLoading> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(MyColors.refresh), 
    );
  }
}
