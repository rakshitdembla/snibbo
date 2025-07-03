import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/network/web_sockets/web_sockets_services.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/service_locator.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;
  final String chatId;
  final Future<void> Function() toogleToEmojiKeyboard;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.node,
    required this.chatId,
    required this.toogleToEmojiKeyboard,
  });

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.005,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: toogleToEmojiKeyboard,
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey[700],
                      size: height * 0.027,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: TextField(
                      focusNode: node,
                      cursorColor: MyColors.secondaryDense,
                      cursorErrorColor: MyColors.secondaryDense,
                      controller: controller,
                      onChanged: (value) {
                        sl<WebSocketsServices>().onChangedTyping(
                          chatId: chatId,
                        );
                      },
                      style: TextStyle(
                        fontSize: height * 0.018,
                        color: MyColors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                      minLines: 1,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: width * 0.02),
          Container(
            height: height * 0.052,
            decoration: BoxDecoration(
              color: MyColors.secondaryDense,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: height * 0.026,
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  sl<WebSocketsServices>().emitNewMessage(
                    context: context,
                    chatId: chatId,
                    text: controller.text,
                  );
                  controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
