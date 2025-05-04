import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';

extension CustomThemeColors on BuildContext {
  bool get isDark => watch<ThemeBloc>().state is DarkThemeState;

  Color get toastBackground =>
      isDark ? MyColors.black : MyColors.white;
}
