import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class TabBarWidget extends StatelessWidget {
  final List<Widget> tabs;
  final TabController tabcontroller;
  final EdgeInsetsGeometry padding;
  const TabBarWidget({super.key, required this.tabs,required this.tabcontroller,required this.padding});

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
        final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Container(
      color: isDark ? MyColors.darkPrimary :  MyColors.primary,
      child: TabBar(
        controller: tabcontroller,
        splashFactory: NoSplash.splashFactory,
        dividerColor: MyColors.lowOpacitySecondary,
        dividerHeight: height * 0.00060,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.white,
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: MyColors.secondary,
            width: width * 0.0070,
          ),
          insets: padding
        ),
        tabs: tabs,
      ),
    );
  }
}
