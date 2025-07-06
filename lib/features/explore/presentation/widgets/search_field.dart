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
  final String hintText;
  final bool isMini;
  final Function(String)? onChanged;

  const SearchField({
    super.key,
    required this.focusNode,
    required this.isMini,
    required this.textEditingController,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return SizedBox(
      width: width,
      height: isMini ? height * 0.045 : height * 0.05,
      child: TextField(
        maxLines: 1,
        cursorColor: MyColors.grey,
        cursorErrorColor: MyColors.grey,
        controller: textEditingController,
        focusNode: focusNode,
        style: TextStyle(   overflow: TextOverflow.ellipsis,
          color: isDark ? MyColors.white : MyColors.black,
          fontWeight: FontWeight.w500,
          fontSize: isMini ? height * 0.0165 : height * 0.0165,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(   overflow: TextOverflow.ellipsis,
            color: MyColors.lowOpacitySecondary,
            fontWeight: FontWeight.w500,
            fontSize: isMini ? height * 0.0139 : height * 0.0148,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: isDark ? MyColors.white : MyColors.black,
          ),
          filled: true,
          fillColor: MyColors.searchField,
          counter: SizedBox.shrink(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
        ),
      ),
    );
  }
}
