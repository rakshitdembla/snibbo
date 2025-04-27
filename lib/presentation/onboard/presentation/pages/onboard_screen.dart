import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widget/elevated_cta.dart';
import 'package:snibbo_app/core/widget/elevated_outlined_cta.dart';
import 'package:snibbo_app/core/widget/text_span_bottom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/presentation/onboard/presentation/widget/on_board_dots.dart';
import 'package:snibbo_app/presentation/onboard/presentation/widget/on_board_page.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

@RoutePage()
class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.035),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.7,
                width: width,

                child: PageView(
                  onPageChanged: (value) {
                    index = value;
                  },
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    OnBoardPage(
                      onBoardDots: OnBoardDots(
                        centerImagePath: MyAssets.loveMemoji,
                        leftImage1Path: MyAssets.confusedMemoji,
                        leftImage2Path: MyAssets.chillMemoji,
                        leftImage3Path: MyAssets.punchMemoji,
                        rightImage1Path: MyAssets.smileMemoji,
                        rightImage2Path: MyAssets.starsMemoji,
                        rightImage3Path: MyAssets.macMemoji,
                      ),
                      h1: "Stay Close to Your\nLoved Ones",
                      h2:
                          "Easily connect with your family\nand friends and feel more connected.",
                    ),

                    OnBoardPage(
                      h1: "Meet New People\nEffortlessly",
                      h2:
                          "It's easy to find and connect\nwith new friends who share your interests.",
                      onBoardDots: OnBoardDots(
                        centerImagePath: MyAssets.eyeMemoji,
                        leftImage1Path: MyAssets.loveMemoji,
                        leftImage2Path: MyAssets.partyMemoji,
                        leftImage3Path: MyAssets.partyMemoji,
                        rightImage1Path: MyAssets.thinkingMemoji,
                        rightImage2Path: MyAssets.confusedMemoji,
                        rightImage3Path: MyAssets.happyMemoji,
                      ),
                    ),

                    OnBoardPage(
                      h1: "Share Your Thoughts\nFreely",
                      h2:
                          "Use Snibbo to share what's on your\nmind with the world, without any limits.",
                      onBoardDots: OnBoardDots(
                        centerImagePath: MyAssets.punchMemoji,
                        leftImage1Path: MyAssets.confusedMemoji,
                        leftImage2Path: MyAssets.chillMemoji,
                        leftImage3Path: MyAssets.starsMemoji,
                        rightImage1Path: MyAssets.shyGirlMemoji,
                        rightImage2Path: MyAssets.loveMemoji,
                        rightImage3Path: MyAssets.smileMemoji,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 11.0.h,
                    dotWidth: 11.0.w,
                    activeDotColor: MyColors.secondary,
                    dotColor: MyColors.secondaryGrey,
                  ),
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      index,
                    );
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              ElevatedCTA(
                onPressed: () {
                  if (index == 2) {
                    context.router.push(RegisterScreenRoute());
                  } else {
                    pageController.animateToPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      index + 1,
                    );
                  }
                },
                buttonName: "Next",
                isShort: false,
              ),
              SizedBox(height: height * 0.015),
              ElevatedOutlinedCTA(
                onPressed: () {
                  context.router.push(RegisterScreenRoute());
                },
                buttonName: "Skip",
                isShort: false,
              ),

              SizedBox(height: height * 0.03),
              TextSpanBottom(
                actionTitle: " Log In",
                onTap: () {
                  context.router.push(LoginScreenRoute());
                },
                title: "Already have an account?",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
