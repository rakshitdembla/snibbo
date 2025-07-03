import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/network/web_sockets/web_sockets_services.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/error_screen.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_messages_bloc/get_messages_bloc.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_messages_bloc/get_messages_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_messages_bloc/get_messages_states.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/chat_input_bar.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/chat_screen_appbar_userinfo.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/emoji_picker_widget.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/my_message_widget.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/user_message_widget.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';
import 'package:snibbo_app/service_locator.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final String username;
  final String? profilePicture;
  final bool isOnline;
  final String? lastSeen;
  const ChatScreen({
    super.key,
    required this.profilePicture,
    required this.username,
    required this.isOnline,
    required this.lastSeen,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isEmojiVisible = false;
  late TextEditingController textController;
  late FocusNode node;
  late ScrollController scrollController;
  late MessagesBloc messagesBloc;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    node = FocusNode();
    scrollController = ScrollController();
    messagesBloc = BlocProvider.of<MessagesBloc>(context);
    messagesBloc.add(GetMessages(username: widget.username));
    scrollController.addListener(_listener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_listener);
    textController.dispose();
    node.dispose();
    scrollController.dispose();
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
              iconTheme: IconThemeData(color: MyColors.white),
              backgroundColor: MyColors.secondaryDense,
              title: GestureDetector(
                onTap: () {
                  context.router.push(
                    UserProfileScreenRoute(username: widget.username),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserCircularProfileWidget(
                      username: widget.username,
                      isStatic: true,
                      profileUrl: widget.profilePicture,
                      margins: EdgeInsets.zero,
                      storySize: 0.05,
                      isAllStoriesViewed: false,
                      hasActiveStories: false,
                    ),
                    SizedBox(width: width * 0.02),
                    BlocBuilder<MessagesBloc, MessagesStates>(
                      buildWhen: (previous, current) {
                        if (current is MessagesLoaded) {
                          return current.username == widget.username;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        if (state is MessagesLoaded) {
                          return ChatScreenAppbarUserinfo(
                            chatId: messagesBloc.messagesChatId,
                            lastSeen: widget.lastSeen,
                            isOnline: widget.isOnline,
                            username: widget.username,
                          );
                        }
                        return ChatScreenAppbarUserinfo(
                          lastSeen: widget.lastSeen,
                          isOnline: widget.isOnline,
                          username: widget.username,
                        );
                      },
                    ),
                  ],
                ),
              ),
              centerTitle: false,
            ),
            body: BlocConsumer<MessagesBloc, MessagesStates>(
              listenWhen: (previous, current) {
                if (current is MessagesError) {
                  return current.username == widget.username;
                } else if (current is MessagesPaginationError) {
                  return current.username == widget.username;
                } else if (current is MessagesLoaded) {
                  return current.username == widget.username;
                } else if (current is SocketMessagesUpdate) {
                  return true;
                }
                return false;
              },
              listener: (context, state) {
                if (state is MessagesError) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: false,
                    isWarning: false,
                  );
                } else if (state is MessagesPaginationError) {
                  UiUtils.showToast(
                    title: state.title,
                    isDark: isDark,
                    description: state.description,
                    context: context,
                    isSuccess: false,
                    isWarning: false,
                  );
                } else if (state is MessagesLoaded ||
                    state is SocketMessagesUpdate) {
                  sl<WebSocketsServices>().emitMessagesSeen(
                    chatId: messagesBloc.messagesChatId,
                  );
                }
              },
              buildWhen: (previous, current) {
                if (current is MessagesLoading) {
                  return current.username == widget.username;
                } else if (current is MessagesLoaded) {
                  return current.username == widget.username;
                } else if (current is MessagesPaginationSuccess) {
                  return current.username == widget.username;
                } else if (current is SocketMessagesUpdate) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is MessagesLoading) {
                  return const Center(child: CircularProgressLoading());
                }

                if (state is MessagesError) {
                  return ErrorScreen(isFeedError: false);
                }
                return LayoutBuilder(
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
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  reverse: true,
                                  itemCount:
                                      messagesBloc.allMessages.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        messagesBloc.allMessages.length) {
                                      return messagesBloc.hasMore
                                          ? Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: height * 0.025,
                                                bottom: height * 0.02,
                                              ),
                                              child: CircularProgressLoading(),
                                            ),
                                          )
                                          : SizedBox.shrink();
                                    }
                                    final message =
                                        messagesBloc.allMessages[index];
                                    return Row(
                                      mainAxisAlignment:
                                          message.isSentByMe
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: width * 0.7,
                                          ),
                                          child:
                                              message.isSentByMe
                                                  ? MyMessageWidget(
                                                    messageEntity: message,
                                                  )
                                                  : UserMessageWidget(
                                                    messageEntity: message,
                                                  ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ChatInputBar(
                                  chatId: messagesBloc.messagesChatId,
                                  toogleToEmojiKeyboard: toogleToEmojiKeyboard,
                                  controller: textController,
                                  node: node,
                                ),
                              ),
                              Visibility(
                                visible: isEmojiVisible,
                                child: EmojiPickerWidget(
                                  controller: textController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
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

  void _listener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (messagesBloc.hasMore && !messagesBloc.isLoading) {
        messagesBloc.add(LoadMoreMessages(username: widget.username));
      }
    }
  }
}
