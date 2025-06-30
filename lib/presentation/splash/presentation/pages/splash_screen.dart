import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';
import 'package:snibbo_app/presentation/splash/presentation/widgets/dots.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Scaffold(
      body: Stack(
        children: [
          Dots().animate().shimmer(duration: 1000.ms, delay: 500.ms),
          Center(
            child: Image.asset(
              height: height * 0.45,
              width: width * 0.45,
              isDark ? MyAssets.whiteTextLogo : MyAssets.darkTextLogo,
            ),
          ).animate().fadeIn(duration: 600.ms),
        ],
      ),
    );
  }

  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 1));

    final username = await ServicesUtils.getUsername();
    final tokenId = await ServicesUtils.getTokenId();

    if (!mounted) return;

    if (username != null && tokenId != null) {
      context.router.replace(const GeneralPageRoute());
    } else {
      context.router.replace(const OnboardScreenRoute());
    }
  }
}
