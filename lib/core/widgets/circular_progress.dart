import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class CircularProgressLoading extends StatefulWidget {
  const CircularProgressLoading({super.key});

  @override
  State<CircularProgressLoading> createState() =>
      _CircularProgressLoadingState();
}

class _CircularProgressLoadingState extends State<CircularProgressLoading> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(
        isDark ? MyColors.white : MyColors.refresh,
      ),
    );
  }
}

class SecondaryCircularProgress extends StatefulWidget {
    final double? scaleSize;
  const SecondaryCircularProgress({super.key,this.scaleSize});

  @override
  State<SecondaryCircularProgress> createState() =>
      _SecondaryCircularProgressState();
}

class _SecondaryCircularProgressState extends State<SecondaryCircularProgress> {
  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    return Transform.scale(
      scale: widget.scaleSize  ??  width * 0.0035,
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(MyColors.white),
      ),
    );
  }
}
