import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class CaptionsTextField extends StatelessWidget {
  final TextEditingController captionController;
  final FocusNode captionNode;
  const CaptionsTextField({
    super.key,
    required this.captionController,
    required this.captionNode,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return TextField(
      cursorColor: MyColors.secondaryDense,
      cursorErrorColor: MyColors.secondaryDense,
      controller: captionController,
      focusNode: captionNode,
      style: TextStyle(
        color: isDark ? MyColors.white : MyColors.grey,
        fontWeight: FontWeight.w500,
        fontSize: height * 0.018,
      ),
      onSubmitted: (String value) {
        FocusScope.of(context).unfocus();
      },
      maxLength: 600,
      textAlign: TextAlign.start,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: height * 0.015,
          horizontal: width * 0.025,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: MyColors.searchField),
        ),
        counterStyle: TextStyle(color: MyColors.grey),
        filled: true,
        fillColor: isDark ? MyColors.darkTextFields : MyColors.textFields,
      ),
    );
  }
}
