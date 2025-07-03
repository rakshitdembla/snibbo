import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class CircularProgressLoading extends StatefulWidget {
  final double? androidScaleSize;
  final double? iosScaleSize;
  const CircularProgressLoading({
    super.key,
    this.androidScaleSize,
    this.iosScaleSize,
  });

  @override
  State<CircularProgressLoading> createState() =>
      _CircularProgressLoadingState();
}

class _CircularProgressLoadingState extends State<CircularProgressLoading> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    if (Platform.isAndroid) {
      return Transform.scale(
        alignment: Alignment.center,
        scale: widget.androidScaleSize ?? UiUtils.screenHeight(context) * 0.001,
        child: CircularProgressIndicator(
          color: isDark ? MyColors.white : MyColors.refresh,
          strokeWidth: 4,
        ),
      );
    } else if (Platform.isIOS) {
      return Transform.scale(
        scale: widget.iosScaleSize ?? UiUtils.screenHeight(context) * 0.001,
        child: CupertinoActivityIndicator(
          color: isDark ? MyColors.white : MyColors.refresh,
        ),
      );
    }
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(
        isDark ? MyColors.white : MyColors.refresh,
      ),
    );
  }
}
