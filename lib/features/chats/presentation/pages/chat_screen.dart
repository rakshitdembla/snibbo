import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/chat_input_bar.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/emoji_picker_widget.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/user_message_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';


@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  bool isEmojiVisible = false;
  late TextEditingController controller;
  late FocusNode node;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    node = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return KeyboardVisibilityBuilder(
      builder: (context, isVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (isVisible && isEmojiVisible) {
            setState(() {
              isEmojiVisible = false;
            });
          }
        });
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
            if (isEmojiVisible) {
              setState(() {
                isEmojiVisible = false;
              });
            }
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Platform.isAndroid
                      ? Icons.arrow_back
                      : Icons.arrow_back_ios_new,
                  color: MyColors.white,
                ),
                onPressed: () => context.router.pop(),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.more_vert_outlined, color: MyColors.white),
                  onPressed: () {},
                ),
              ],
              iconTheme: IconThemeData(color: MyColors.white),
              backgroundColor: MyColors.secondaryDense,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserCircularProfileWidget(
                    profileUrl: "",
                    margins: EdgeInsets.zero,
                    storySize: 0.05,
                    greyBorder: false,
                    showBorder: false,
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "rakshitdembla",
                          style: TextStyle(
                            fontSize: height * 0.016,
                            overflow: TextOverflow.ellipsis,
                            color: MyColors.white,
                          ),
                        ),
                        SizedBox(height: height * 0.004),
                        Text(
                          "Typing...",
                          style: TextStyle(
                            color: MyColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.013,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              centerTitle: false,
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Opacity(
                      opacity: isDark ? 0.025 : 0.3,
                      child: Image.asset(
                        MyAssets.chatBG,
                        fit: BoxFit.cover,
                        height: constraints.maxHeight + kToolbarHeight,
                        width: double.infinity,
                      ),
                    ),
                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: width * 0.7,
                                ),
                                child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return UserMessageWidget();
                                  },
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ChatInputBar(
                              toogleToEmojiKeyboard: toogleToEmojiKeyboard,
                              controller: controller,
                              onSend: () {},
                              node: node,
                            ),
                          ),
                          Visibility(
                            visible: isEmojiVisible,
                            child: EmojiPickerWidget(controller: controller),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> toogleToEmojiKeyboard() async {
    if (!isEmojiVisible) {
      FocusScope.of(context).unfocus();
      await Future.delayed(Duration(milliseconds: 150));
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });

    if (!isEmojiVisible) {
      if (mounted) {
        FocusScope.of(context).requestFocus(node);
      }
    }
  }
}
