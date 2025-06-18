import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/theme/myfonts.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class ElevatedOutlinedCTA extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonName;
  final bool isShort;
  const ElevatedOutlinedCTA({
    super.key,
    required this.onPressed,
    required this.buttonName,
    required this.isShort,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return SizedBox(
      width: isShort ? width * 0.44 : width,
      height: isShort ? height * 0.04 : height * 0.055,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: isShort ? 0.7.r : 1.r,
              color: isDark ? MyColors.white : MyColors.black,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          backgroundColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: TextStyle(
            fontFamily: MyFonts.assetsFontFamily(),
            color: isDark ? MyColors.white : MyColors.black,
            fontWeight: isShort ? FontWeight.w600 : FontWeight.w600,
            fontSize: isShort ? height * 0.0165 : height * 0.020,
          ),
        ),
      ),
    );
  }
}
