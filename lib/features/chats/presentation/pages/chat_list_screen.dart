import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/error_screen.dart';
import 'package:snibbo_app/core/widgets/refresh_bar.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_bloc.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_states.dart';
import 'package:snibbo_app/features/chats/presentation/widgets/user_chat_tile.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';

@RoutePage()
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late ScrollController _controller;
  late ChatsListBloc chatsListBloc;
  @override
  void initState() {
    _controller = ScrollController();
    chatsListBloc = BlocProvider.of<ChatsListBloc>(context);
    chatsListBloc.add(GetChatsList());
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: MyColors.white),
        title: Text("Recent Chats"),
      ),
      body: MyRefreshBar(
        onRefresh: () async {
          await Future.delayed(500.ms);
          chatsListBloc.add(GetChatsList());
        },
        widget: SafeArea(
          child: BlocConsumer<ChatsListBloc, ChatsListStates>(
            listener: (context, state) {
              if (state is ChatsListError) {
                UiUtils.showToast(
                  title: state.title,
                  isDark: isDark,
                  description: state.description,
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              } else if (state is ChatsListPaginationError) {
                UiUtils.showToast(
                  title: state.title,
                  isDark: isDark,
                  description: state.description,
                  context: context,
                  isSuccess: false,
                  isWarning: false,
                );
              }
            },
            builder: (context, state) {
              if (state is ChatsListLoading) {
                return Center(child: CircularProgressLoading());
              } else if (state is ChatsListError) {
                return ErrorScreen(isFeedError: false,);
              }
              return ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _controller,
                padding: EdgeInsets.only(top: height * 0.007),
                itemCount: chatsListBloc.allChats.length + 1,
                itemBuilder: (context, index) {
                  if (index == chatsListBloc.allChats.length) {
                    return chatsListBloc.hasMore
                        ? Center(child: CircularProgressLoading())
                        : SizedBox.shrink();
                  }
                  final chat = chatsListBloc.allChats[index];
                  return UserChatTile(chat: chat,);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (chatsListBloc.hasMore && !chatsListBloc.isLoading) {
        chatsListBloc.add(LoadMoreChatsList());
      }
    }
  }
}
