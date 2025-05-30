import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/like_post_bloc/like_post_bloc.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/like_post_bloc/like_post_events.dart';
import 'package:snibbo_app/features/feed/presentation/bloc/like_post_bloc/like_post_states.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/posts/post_action_icon.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
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
            left: width * 0.03,
            bottom: height * 0.003,
            top: height * 0.01,
          ),
          child: Row(
            children: [
              UserCircularProfileWidget(
                showBorder: true,
                greyBorder: false,
                isMini: true,
                profileUrl: MyAssets.demoUser,
                storySize: 0.053,
                margins: EdgeInsets.only(right: width * 0.02),
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
                    return Icon(
                          LineIcons.heartAlt,
                          color: Colors.redAccent,
                          size: width * 0.3,
                        )
                        .animate(onComplete: (controller) => controller.stop())
                        .fadeIn(duration: 400.ms)
                        .scale(
                          duration: 400.ms,
                          curve: Curves.easeOutBack,
                          begin: Offset(0.5, 0.5),
                          end: Offset(1.2, 1.2),
                        )
                        .then()
                        .moveY(
                          begin: 0,
                          end: -30,
                          duration: 700.ms,
                          curve: Curves.easeOut,
                        )
                        .rotate(begin: -0.1, end: 0.1, duration: 700.ms)
                        .fadeOut(duration: 500.ms);
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
                count: "5",
                icon: LineIcons.heart,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              SizedBox(width: width * 0.04),
              PostActionIcon(
                count: "51",
                icon: LineIcons.comments,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              SizedBox(width: width * 0.04),

              PostActionIcon(
                count: "",
                icon: LineIcons.telegramPlane,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              Spacer(),
              PostActionIcon(
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
