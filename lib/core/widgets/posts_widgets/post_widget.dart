import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/animated_like.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/like_post_bloc/like_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/like_post_bloc/like_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/like_post_bloc/like_post_states.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/post_action_icon.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/core/widgets/posts_widgets/show_comments_sheet.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class PostWidget extends StatefulWidget {
  final String postContentUrl;
  const PostWidget({super.key, required this.postContentUrl});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late bool showingLike;
  @override
  void initState() {
    showingLike = context.read<LikePostBloc>().state is TapLikeShowState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: width * 0.013,
            bottom: height * 0.003,
            top: height * 0.015,
          ),
          child: Row(
            children: [
              UserCircularProfileWidget(
                showBorder: false,
                greyBorder: false,
                
                profileUrl: MyAssets.demoUser,
                storySize: 0.055,
                margins: EdgeInsets.only(right: width * 0.01),
              ),
              GestureDetector(
                onTap: () {
                  context.router.push(UserProfileScreenRoute());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rakshit Dembla",
                      style: TextStyle(
                        fontSize: width * 0.033,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: height * 0.0025),
                    Text(
                      "@rakshitdembla",
                      style: TextStyle(
                        fontSize: width * 0.030,
                        color: MyColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: isDark ? MyColors.white : MyColors.black,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () async {
            if (showingLike) {
              return;
            }

            context.read<LikePostBloc>().add(TapLike());
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                widget.postContentUrl,
                width: width,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return UiUtils.showShimmerBuilder(
                    wasSynchronouslyLoaded: wasSynchronouslyLoaded,
                    frame: frame,
                    child: child,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    MyAssets.demoUser,
                    width: width,
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
                  );
                },
              ),

              BlocBuilder<LikePostBloc, LikePostStates>(
                builder: (context, state) {
                  if (state is TapLikeShowState) {
                    return 
                        AnimatedLike(widget: Icon(
                          LineIcons.heartAlt,
                          color: Colors.redAccent,
                          size: width * 0.3,
                        ));
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: width * 0.023,
            right: width * 0.02,
            top: height * 0.008,
            bottom: height * 0.01,
          ),
          child: Row(
            children: [
              PostActionIcon(
                onTap: () {},
                count: "5",
                icon: LineIcons.heart,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              SizedBox(width: width * 0.04),
              PostActionIcon(
                onTap: () {
                  ShowCommentsSheet.show(context: context, isDark: isDark);
                },
                count: "51",
                icon: LineIcons.comments,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              SizedBox(width: width * 0.04),

              PostActionIcon(
                onTap: () {},
                count: "",
                icon: LineIcons.telegramPlane,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              Spacer(),
              PostActionIcon(
                onTap: () {},
                count: "",
                icon: LineIcons.bookmark,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "rakshitdembla",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.03,
                    color: isDark ? MyColors.white : MyColors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                          " Ghibli Trend in which chatGpt by OpenAi came in trend and it got so much viral...",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: width * 0.035,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                    ),
                    TextSpan(
                      text: " more",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: width * 0.035,
                        color: MyColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.0020),
              Text(
                "14 April 2025",
                style: TextStyle(color: MyColors.grey, fontSize: width * 0.028),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
