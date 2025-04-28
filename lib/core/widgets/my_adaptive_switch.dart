import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class MyAdaptiveSwitch extends StatelessWidget {
  final ValueChanged<bool>? onChanged;
  final bool value;
  const MyAdaptiveSwitch({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return SizedBox(
      width: width * 0.14,
      height: height * 0.04,
      child: Switch.adaptive(
        value: value,
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        inactiveTrackColor: const Color.fromARGB(255, 110, 113, 116),
        inactiveThumbColor: Colors.white,
        onChanged: onChanged,
        activeTrackColor: MyColors.secondary,
      ),
    );
  }
}
