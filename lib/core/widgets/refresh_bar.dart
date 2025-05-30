import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class MyRefreshBar extends StatelessWidget {
  final Widget widget;
  final Future<void> Function() onRefresh;
  const MyRefreshBar({
    super.key,
    required this.widget,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      color: isDark ? MyColors.primary : MyColors.darkPrimary,
      backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,
      child: widget,
    );
  }
}
