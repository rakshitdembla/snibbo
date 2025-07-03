import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class MyTextField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final int maxLength;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final ValueChanged<String>? onSubmit;
  final IconData prefixIcon;
  const MyTextField({
    super.key,
    required this.label,
    required this.focusNode,
    required this.isPassword,
    required this.textEditingController,
    this.inputFormatters,
    required this.maxLength,
    required this.maxLines,
    required this.onSubmit,
    required this.prefixIcon,
    required this.hintText,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.0040),
          child: Text(
            widget.label,
            style: TextStyle(
              color: MyColors.grey,
              fontWeight: FontWeight.w600,
              fontSize: width * 0.035,
            ),
          ),
        ),
        SizedBox(height: height * 0.0030),
        SizedBox(
          width: width,
          child: TextField(
            inputFormatters: widget.inputFormatters ?? [],
            cursorColor: MyColors.secondaryDense,
            cursorErrorColor: MyColors.secondaryDense,
            controller: widget.textEditingController,
            focusNode: widget.focusNode,
            style: TextStyle(
              color: isDark ? MyColors.white : MyColors.grey,
              fontWeight: FontWeight.w500,
              fontSize: height * 0.02,
            ),
            onSubmitted: widget.onSubmit,
            maxLength: widget.maxLength,
            obscureText: widget.isPassword,
            textAlign: TextAlign.start,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: height * 0.02,
                horizontal: width * 0.02,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: MyColors.lowOpacitySecondary,
                fontWeight: FontWeight.w400,
                fontSize: height * 0.02,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: MyColors.searchField),
              ),
              filled: true,
              counter: SizedBox.shrink(),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: MyColors.secondary,
                size: height * 0.027,
              ),
              iconColor: MyColors.secondary,
              fillColor: isDark ? MyColors.darkTextFields : MyColors.textFields,
            ),
          ),
        ),
      ],
    );
  }
}
