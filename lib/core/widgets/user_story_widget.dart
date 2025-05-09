import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserStoryWidget extends StatelessWidget {
  final EdgeInsetsGeometry margins;
  final String profileUrl;
  final double storySize;
  final bool showLike;
  final bool isMini;
  final bool showComment;
  final bool showBorder;
  final bool greyBorder;

  const UserStoryWidget({
    super.key,
    required this.profileUrl,
    required this.margins,
    required this.storySize,
    required this.showLike,
    required this.isMini,
    required this.showComment,
    required this.greyBorder,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final storyRadius = height * storySize;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.router.push(StoryViewScreenRoute());
          },
          child: Container(
            padding: EdgeInsets.all(
              isMini ? storyRadius * 0.050 : storyRadius * 0.04,
            ),
            margin: margins,
            height: storyRadius,
            width: storyRadius,
            decoration: BoxDecoration(
              gradient:
                  showBorder
                      ? greyBorder
                          ? null
                          : MyColors.gradient
                      : null,
              color:
                  showBorder
                      ? greyBorder
                          ? MyColors.lowOpacitySecondary
                          : null
                      : null,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: EdgeInsets.all(
                isMini ? storyRadius * 0.06 : storyRadius * 0.03,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? MyColors.darkPrimary : MyColors.primary,
              ),
              child: ClipOval(
                child: Image.network(
                  profileUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(MyAssets.profilePictureHolder, fit: BoxFit.cover);
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: showComment ? height * 0.45 : height * 0.5,
          left: storyRadius * 0.65,
          child: Icon(
            showComment ? Icons.add_comment_rounded : Icons.favorite_rounded,
            color:
                showComment
                    ? isDark
                        ? MyColors.white
                        : MyColors.secondary
                    : Colors.red,
            size:
                showLike
                    ? storyRadius * 0.3
                    : showComment
                    ? storyRadius * 0.3
                    : 0,
          ),
        ),
      ],
    );
  }
}
