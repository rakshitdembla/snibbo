import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserStoryWidget extends StatelessWidget {
  final EdgeInsetsGeometry margins;
  final double height;
  final double width;
  final EdgeInsetsGeometry insidePadding;
  final EdgeInsetsGeometry outsidePadding;
  final String profileUrl;
  final bool? showLike;
  final bool? isComment;

  const UserStoryWidget({
    super.key,
    required this.profileUrl,
    required this.height,
    required this.margins,
    required this.width,
    required this.insidePadding,
    required this.outsidePadding,
    this.showLike,
    this.isComment,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.router.push(StoryViewScreenRoute());
          },
          child: Container(
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
          ),
        ),
        Positioned(
          top:
              isComment != null && isComment == true
                  ? height * 0.45
                  : height * 0.5,
          left: width * 0.65,
          child: Icon(
            isComment != null && isComment == true
                ? Icons.add_comment_rounded
                : Icons.favorite_rounded,
            color:
                isComment != null && isComment == true
                    ? isDark
                        ? MyColors.white
                        : MyColors.secondary
                    : Colors.red,
            size:
                showLike != null && showLike == true
                    ? width * 0.3
                    : isComment != null && isComment == true
                    ? width * 0.3
                    : 0,
          ),
        ),
      ],
    );
  }
}
