import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

class EmojiPickerWidget extends StatelessWidget {
  final TextEditingController controller;
  const EmojiPickerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        controller.text = controller.text + emoji.emoji;
      },
      config: Config(
        bottomActionBarConfig: BottomActionBarConfig(
          showBackspaceButton: false,
        ),
        emojiViewConfig: EmojiViewConfig(
          columns: 8
          
        ),
        height: height * 0.34,
        emojiTextStyle: TextStyle(fontSize: height * 0.035),
      ),
    );
  }
}
