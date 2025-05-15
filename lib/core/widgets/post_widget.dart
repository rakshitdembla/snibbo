import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/feed/presentation/widgets/post_action_icon.dart';
import 'package:snibbo_app/core/widgets/user_profile_pic_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';
import 'package:snibbo_app/test_list.dart';

class PostWidget extends StatefulWidget {
  final String postContentUrl;
  const PostWidget({super.key, required this.postContentUrl});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final testList = TestList.test();
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
              UserProfilePicWidget(
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
          onDoubleTap: () {},
          child: Image.network(
            widget.postContentUrl, width: width,errorBuilder: (context, error, stackTrace) {
            return Image.asset(MyAssets.demoUser,width: width,);
          },),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.01,
          ),
          child: Row(
            children: [
              PostActionIcon(
                count: "5",
                icon: Icons.favorite_border_rounded,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              SizedBox(width: width * 0.035),
              PostActionIcon(
                count: "51",
                icon: Icons.mode_comment_outlined,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              SizedBox(width: width * 0.035),

              PostActionIcon(
                count: "5",
                icon: Icons.share_outlined,
                iconColor: isDark ? MyColors.white : MyColors.black,
              ),
              Spacer(),
              PostActionIcon(
                count: "",
                icon: Icons.bookmark_add_outlined,
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
