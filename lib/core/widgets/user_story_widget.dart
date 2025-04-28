import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class UserStoryWidget extends StatelessWidget {
  final EdgeInsetsGeometry margins;
  final double height;
  final double width;
  final EdgeInsetsGeometry insidePadding;
  final EdgeInsetsGeometry outsidePadding;
  final String profileUrl;

  const UserStoryWidget({
    super.key,
    required this.profileUrl,
    required this.height,
    required this.margins,
    required this.width,
    required this.insidePadding,
    required this.outsidePadding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Container(
      padding: outsidePadding,
      margin: margins,
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: MyColors.gradient,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: insidePadding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? MyColors.darkPrimary : MyColors.primary,
        ),
        child: ClipOval(
          child: Image.asset(profileUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
