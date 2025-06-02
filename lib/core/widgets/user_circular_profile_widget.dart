import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/feed/domain/entities/user_entity.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserCircularProfileWidget extends StatefulWidget {
  final EdgeInsetsGeometry margins;
  final dynamic profileUrl;
  final bool? isFile;
  final double storySize;
  final String? username;
  final bool showBorder;
  final bool greyBorder;
  final List<UserEntity>? storyUsers;

  const UserCircularProfileWidget({
    super.key,
    required this.profileUrl,
    required this.margins,
    required this.storySize,
    this.username,
    required this.greyBorder,
    required this.showBorder,
    this.storyUsers,
    this.isFile,
  });

  @override
  State<UserCircularProfileWidget> createState() => _UserStoryWidgetState();
}

class _UserStoryWidgetState extends State<UserCircularProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final storyRadius = height * widget.storySize;

    //Base story widget -->
    final storyWidget = Container(
      padding: EdgeInsets.all(storyRadius * 0.04),
      margin: widget.margins,
      height: storyRadius,
      width: storyRadius,
      decoration: BoxDecoration(
        gradient:
            widget.showBorder
                ? widget.greyBorder
                    ? null
                    : MyColors.gradient
                : null,
        color:
            widget.showBorder
                ? widget.greyBorder
                    ? MyColors.lowOpacitySecondary
                    : null
                : null,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: EdgeInsets.all(storyRadius * 0.03),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? MyColors.darkPrimary : MyColors.primary,
        ),
        child: ClipOval(
          child:
              widget.isFile != null && widget.isFile!
                  ? Image.file(
                    widget.profileUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        MyAssets.profilePictureHolder,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                  : Image.network(
                    widget.profileUrl,
                    fit: BoxFit.cover,
                    frameBuilder: (
                      context,
                      child,
                      frame,
                      wasSynchronouslyLoaded,
                    ) {
                      return UiUtils.showShimmerBuilder(
                        wasSynchronouslyLoaded: wasSynchronouslyLoaded,
                        frame: frame,
                        child: child,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        MyAssets.profilePictureHolder,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
        ),
      ),
    );

    return widget.username != null
        ? GestureDetector(
          onTap: () {
            {
              context.router.push(
                FetchStoriesLoadingRoute(
                  storyUsers: widget.storyUsers,
                  username: widget.username!,
                  isPreviousSlide: false,
                  profilePicture: widget.profileUrl,
                ),
              );
            }
          },
          child: storyWidget,
        )
        : storyWidget;
  }
}
