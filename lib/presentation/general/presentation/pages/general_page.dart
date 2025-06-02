import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/features/activity/presentation/pages/activity_screen.dart';
import 'package:snibbo_app/features/explore/presentation/pages/explore_screen.dart';
import 'package:snibbo_app/features/feed/presentation/pages/feed_screen.dart';
import 'package:snibbo_app/features/create/presentation/pages/create_post_screen.dart';
import 'package:snibbo_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/general/presentation/widgets/bottom_nav_bar_item.dart';

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
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: PersistentTabView(
          controller: _controller,
          backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,
          isVisible: true,
          confineToSafeArea: false,
          navBarHeight: kBottomNavigationBarHeight,
          context,
          items: [
            BottomNavBarItem.item(
              context: context,
              icon: Icons.home_rounded,
              inactiveIcon: Icons.home_outlined,
            ),
            BottomNavBarItem.item(
              context: context,
              icon: Icons.travel_explore,
              inactiveIcon: Icons.travel_explore_outlined,
            ),
            BottomNavBarItem.item(
              context: context,
              icon: Icons.add_box_rounded,
              inactiveIcon: Icons.add_box_outlined,
            ),
            BottomNavBarItem.item(
              context: context,
              icon: Icons.favorite,
        
              inactiveIcon: Icons.favorite_outline,
            ),
           BottomNavBarItem.item(
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
            ProfileScreen(),
          ],
          navBarStyle: NavBarStyle.style6,
        ),
      ),
    );
  }
}
