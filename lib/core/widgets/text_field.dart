import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final String hintText;
  final ValueChanged<String>? onSubmit;
  final IconData prefixIcon;
  const MyTextField({
    super.key,
    required this.label,
    required this.focusNode,
    required this.isPassword,
    required this.textEditingController,
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
            cursorColor: MyColors.grey,
            cursorErrorColor: MyColors.grey,
            controller: widget.textEditingController,
            focusNode: widget.focusNode,
            style: TextStyle(color: MyColors.grey, fontWeight: FontWeight.w400),

            onSubmitted: widget.onSubmit,
            maxLength: widget.maxLength,
            obscureText: widget.isPassword,
            textAlign: TextAlign.start,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: MyColors.lowOpacitySecondary,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: MyColors.searchField),
              ),
              filled: true,
              counter: SizedBox.shrink(),
              prefixIcon: Icon(widget.prefixIcon, color: MyColors.secondary,
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
