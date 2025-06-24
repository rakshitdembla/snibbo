import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/tab_bar.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/features/user/presentation/widgets/tabs/user_followers_tab.dart';
import 'package:snibbo_app/features/user/presentation/widgets/tabs/user_followings_tab.dart';

@RoutePage()
class UserConnectionsScreen extends StatefulWidget {
  final String username;
  final int initialIndex;
  const UserConnectionsScreen({super.key, required this.username,required this.initialIndex});

  @override
  State<UserConnectionsScreen> createState() => _UserConnectionsScreenState();
}

class _UserConnectionsScreenState extends State<UserConnectionsScreen>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.index = widget.initialIndex;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
        body: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(widget.username),
            ),

            body: Column(
              children: [
                TabBarWidget(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.28),
                  tabs: [
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: height * 0.008,
                      ),
                      child: Text(
                        "Followers",
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color:
                              isDark ? MyColors.primary : MyColors.darkPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: height * 0.008,
                      ),
                      child: Text(
                        "Followings",
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color:
                              isDark ? MyColors.primary : MyColors.darkPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  tabcontroller: _controller,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.007),
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        UserFollowersTab(username: widget.username),
                        UserFollowingsTab(username: widget.username)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
   
  }
}
