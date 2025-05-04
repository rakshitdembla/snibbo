import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
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
      valueColor: AlwaysStoppedAnimation<Color>(isDark ? MyColors.white : MyColors.refresh),
    );
  }
}
