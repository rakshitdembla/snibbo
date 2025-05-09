import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/activity/presentation/pages/activity_screen.dart';
import 'package:snibbo_app/features/explore/presentation/pages/explore_screen.dart';
import 'package:snibbo_app/features/feed/presentation/pages/feed_screen.dart';
import 'package:snibbo_app/features/create/presentation/pages/create_post_screen.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/settings/presentation/pages/settings_page.dart';

@RoutePage()
class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return PersistentTabView(
      controller: _controller,
      backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,
      isVisible: true,
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      context,
      items: [
        UiUtils.navBarItem(
          context: context,
          icon: Icons.home_rounded,

          inactiveIcon: Icons.home_outlined,
        ),
        UiUtils.navBarItem(
          context: context,
          icon: Icons.travel_explore,

          inactiveIcon: Icons.travel_explore_outlined,
        ),
        UiUtils.navBarItem(
          context: context,
          icon: Icons.add_box_rounded,

          inactiveIcon: Icons.add_box_outlined,
        ),
        UiUtils.navBarItem(
          context: context,
          icon: Icons.favorite,

          inactiveIcon: Icons.favorite_outline,
        ),
        UiUtils.navBarItem(
          context: context,
          icon: Icons.person,

          inactiveIcon: Icons.person_outline,
        ),
      ],
      screens: [
        FeedScreen(),
        ExploreScreen(),
        CreatePostScreen(),
        ActivityScreen(),
        SettingsScreen(),
      ],
      navBarStyle: NavBarStyle.style13,
    );
  }
}
