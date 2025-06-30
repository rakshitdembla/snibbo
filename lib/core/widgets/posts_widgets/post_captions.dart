import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class PostCaptions extends StatefulWidget {
  final String username;
  final String postCaption;
  const PostCaptions({
    super.key,
    required this.postCaption,
    required this.username,
  });

  @override
  State<PostCaptions> createState() => _PostCaptionsState();
}

class _PostCaptionsState extends State<PostCaptions> {
  bool isExpanded = false;
  late bool isExpandable;

  @override
  Widget build(BuildContext context) {
    if (widget.postCaption.length > 70) {
      isExpandable = true;
    } else {
      isExpandable = false;
    }
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    return RichText(
      text: TextSpan(
        text: widget.username,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: width * 0.03,
          color: isDark ? MyColors.white : MyColors.black,
        ),
        children: [
          TextSpan(
            text:
                !isExpanded
                    ? isExpandable
                        ? " ${widget.postCaption.substring(0, 67)}..."
                        : " ${widget.postCaption}"
                    : " ${widget.postCaption}",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: width * 0.035,
              color: isDark ? MyColors.white : MyColors.black,
            ),
          ),
          TextSpan(
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      if (isExpanded) {
                        isExpanded = false;
                      } else {
                        isExpanded = true;
                      }
                    });
                  },
            text:
                isExpandable
                    ? isExpanded
                        ? " less"
                        : " more"
                    : "",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: width * 0.035,
              color: MyColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
