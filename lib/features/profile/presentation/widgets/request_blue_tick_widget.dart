import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

class RequestBlueTickWidget extends StatelessWidget {
  const RequestBlueTickWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Column(
      children: [
        Opacity(
          opacity: 0.20,
          child: Divider(
            color: MyColors.grey,
            thickness: 1.0.r,
            radius: BorderRadius.circular(10.r),
          ),
        ),
        SizedBox(height: height * 0.01),
        GestureDetector(
          onTap: () {
                FocusScope.of(context).unfocus();
            UiUtils.showToast(
              title: "Feature Coming Soon",
              description:
                  "Blue tick verification isn't available yet. Stay tuned for updates!",
              isDark: isDark,
              context: context,
              isSuccess: false,
              isWarning: true,
            );
          },
          child: RichText(
            text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: GoogleFonts.poppins(
                color: MyColors.secondaryDense,
                fontWeight: FontWeight.w500,
                fontSize: width * 0.035,
              ),
              children: [
                TextSpan(text: "Request Blue Tick Verification "),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: width * 0.045,
                  ).animate().shimmer(duration: 1500.ms),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
