import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class MiniElevatedOutlinedCTA extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonName;

  const MiniElevatedOutlinedCTA({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;

    return SizedBox(
      height: height * 0.033,
      width: width * 0.25,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: BorderSide(
            color: isDark ? MyColors.white : MyColors.black,
            width: 0.7.r,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          backgroundColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: TextStyle(   overflow: TextOverflow.ellipsis,
            fontFamily: MyFonts.assetsFontFamily(),
            fontWeight: FontWeight.w500,
            fontSize: height * 0.0145,
            color: isDark ? MyColors.white : MyColors.black,
          ),
        ),
      ),
    );
  }
}
