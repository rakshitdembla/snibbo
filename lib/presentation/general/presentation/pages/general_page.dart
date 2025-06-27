import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:snibbo_app/core/network/web_sockets/web_sockets_services.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/features/explore/presentation/pages/explore_screen.dart';
import 'package:snibbo_app/features/feed/presentation/pages/feed_screen.dart';
import 'package:snibbo_app/features/create/presentation/pages/create_post_screen.dart';
import 'package:snibbo_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/general/presentation/bloc/hide_bottom_nav_bloc/hide_bottom_nav_bloc.dart';
import 'package:snibbo_app/presentation/general/presentation/bloc/hide_bottom_nav_bloc/hide_bottom_nav_states.dart';
import 'package:snibbo_app/presentation/general/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:snibbo_app/service_locator.dart';

@RoutePage()
class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => GeneralPageState();
}

class GeneralPageState extends State<GeneralPage> {
  late PersistentTabController _controller;
  final GlobalKey<ProfileScreenState> _profileKey = GlobalKey<ProfileScreenState>();

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(_handleTabChange);
   sl<WebSocketsServices>().connectToSocket(context : context);
    super.initState();
  }

  void _handleTabChange() {
  if (_controller.index == 3) {
    _profileKey.currentState?.initialize();
  }
}


  @override
  void dispose() {
    _controller.dispose();
     _controller.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HideBottomNavBloc, HideBottomNavStates>(
          builder: (context, state) {
            final hideNavBar = context.watch<HideBottomNavBloc>().state is BottomNavBarHidden;
            return PersistentTabView(
              controller: _controller,
              backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,
              isVisible: true,
              confineToSafeArea: false,
              navBarHeight: hideNavBar ? 0 : kBottomNavigationBarHeight,
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
                  icon: Icons.person,
                  inactiveIcon: Icons.person_outline,
                ),
              ],
              screens: [
                FeedScreen(navController: _controller ,),
                ExploreScreen(),
                CreatePostScreen(),
                ProfileScreen(key: _profileKey,),
              ],
              navBarStyle: NavBarStyle.style6,
            );
          },
        ),
      ),
    );
  }
}
