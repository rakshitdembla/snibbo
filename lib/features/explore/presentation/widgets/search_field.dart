import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class SearchField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final String hintText;
  const SearchField({
    super.key,
    required this.focusNode,
    required this.textEditingController,
    required this.prefixIcon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return SizedBox(
      width: width,
      child: TextField(
        cursorColor: MyColors.grey,
        cursorErrorColor: MyColors.grey,
        controller: textEditingController,
        focusNode: focusNode,
        style: TextStyle(
          color: isDark ? MyColors.white : MyColors.black,
          fontWeight: FontWeight.w600,
          fontSize: height * 0.02,
        ),

        decoration: InputDecoration(
  
          hintText: hintText,
          hintStyle: TextStyle(
            color: MyColors.lowOpacitySecondary,
            fontWeight: FontWeight.w500,
            fontSize: height * 0.02,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(prefixIcon, color: isDark? MyColors.white : MyColors.black),
          filled: true,
          fillColor: MyColors.searchField,
          counter: SizedBox.shrink(),
             border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
        ),
      ),
    );
  }
}
