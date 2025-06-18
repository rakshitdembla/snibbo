import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_image_editor/core/platform/io/io_helper.dart';
import 'package:snibbo_app/core/constants/myassets.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/circular_progress.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_bloc.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/get_chats_bloc/get_chats_states.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
            color: MyColors.white,
          ),
          onPressed: () => context.router.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(LineIcons.userPlus, color: MyColors.white),
            onPressed: () {},
          ),
        ],
        iconTheme: IconThemeData(color: MyColors.white),
        backgroundColor: MyColors.secondaryDense,
        title: Text("Chats", style: TextStyle(color: MyColors.white)),
      ),
      body: SafeArea(
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
              return Center(
                child: Lottie.asset(MyAssets.cat404, height: height * 0.15),
              );
            }
            return ListView.builder(
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
                final user = chat.participantInfo;

                String lastMessageHolder() {
                  if (user.isOnline != null && user.isOnline == true) {
                    return "Online🟢";
                  } else {
                    return chat.lastMessage.media != null &&
                            chat.lastMessage.media!.isNotEmpty
                        ? "Media"
                        : chat.lastMessage.text.toString();
                  }
                }
               
                return Slidable(
                  endActionPane: _buildActionPane(context),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: width * 0.01,
                            top: height * 0.003,
                          ),
                          child: Icon(
                            LineIcons.thumbtack,
                            size: height * 0.02,
                            color: MyColors.secondary,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.router.push(ChatScreenRoute());
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            width * 0.02,
                            height * 0.008,
                            width * 0.05,
                            height * 0.008,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UserCircularProfileWidget(
                                profileUrl: user.profilePicture,
                                margins: EdgeInsets.zero,
                                storySize: 0.075,
                                greyBorder: false,
                                showBorder: false,
                              ),
                              SizedBox(width: width * 0.015),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.username,
                                      style: TextStyle(
                                        fontSize: height * 0.016,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.004),
                                    Text(
                                      lastMessageHolder(),
                                      style: TextStyle(
                                        color: MyColors.grey,
                                        fontSize: height * 0.014,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text(
                              ServicesUtils.formattedDate(chat.lastMessage.createdAt),
                                style: TextStyle(fontSize: height * 0.013),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
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

ActionPane _buildActionPane(BuildContext context) {
  return ActionPane(
    motion: const ScrollMotion(),
    children: [
      SlidableAction(
        onPressed: (ctx) {},
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: Icons.block_outlined,
        label: 'Block',
      ),
    ],
  );
}
