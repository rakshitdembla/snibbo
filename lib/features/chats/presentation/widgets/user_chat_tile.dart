import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/features/chats/domain/entities/chat_list_entity.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/block_user_bloc/block_user_bloc.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/block_user_bloc/block_user_events.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/unblock_user_bloc/unbloc_user_bloc.dart';
import 'package:snibbo_app/features/chats/presentation/bloc/unblock_user_bloc/unblock_user_events.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

class UserChatTile extends StatefulWidget {
  final ChatListEntity chat;
  const UserChatTile({super.key, required this.chat});

  @override
  State<UserChatTile> createState() => _UserChatTileState();
}

class _UserChatTileState extends State<UserChatTile> {
  @override
  Widget build(BuildContext context) {
    final user = widget.chat.participantInfo;
    final lastMessage = widget.chat.lastMessage;
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (ctx) {
              if (widget.chat.isBlockedByMe) {
                BlocProvider.of<UnblockUserBloc>(context).add(
                  UnblockUserPressed(
                    username: widget.chat.participantInfo.username,
                  ),
                );
              } else {
                BlocProvider.of<BlockUserBloc>(context).add(
                  BlockUserPressed(
                    username: widget.chat.participantInfo.username,
                  ),
                );
              }

              setState(() {
                widget.chat.isBlockedByMe = !widget.chat.isBlockedByMe;
              });
            },
            backgroundColor:
                !widget.chat.isBlockedByMe ? Colors.red : MyColors.darkRefresh,
            foregroundColor: Colors.white,
            icon: Icons.block_outlined,
            label: !widget.chat.isBlockedByMe ? 'Block' : "Unblock",
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          context.router.push(
            ChatScreenRoute(
              username: user.username,
              profilePicture: user.profilePicture,
              isOnline: user.isOnline ?? false,
              lastSeen:
                  user.lastSeen != null
                      ? DateFormat(
                        'MMM d, yyyy • hh:mm a',
                      ).format(user.lastSeen!)
                      : null,
            ),
          );
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
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  context.router.push(
                    FetchStoriesLoadingRoute(
                      username: widget.chat.participantInfo.username,
                      isPreviousSlide: false,
                      profilePicture:
                          widget.chat.participantInfo.profilePicture.toString(),
                    ),
                  );
                },
                child: UserCircularProfileWidget(
                  isStatic: false,
                  profileUrl: user.profilePicture,
                  margins: EdgeInsets.zero,
                  username: user.username,
                  storySize: 0.075,
                  isAllStoriesViewed:
                      user.hasActiveStories != false
                          ? user.isAllStoriesViewed
                          : null,
                  hasActiveStories: user.hasActiveStories,
                ),
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: height * 0.016,
                      ),
                    ),
                    SizedBox(height: height * 0.004),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          if (lastMessage?.isSentByMe ?? false)
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.only(right: width * 0.01),
                                child: Icon(
                                  lastMessage?.isSeenByOther ?? false
                                      ? Icons.done_all
                                      : Icons.done,
                                  color: MyColors.secondary,
                                  size: height * 0.02,
                                ),
                              ),
                            ),
                          TextSpan(
                            text:
                                lastMessage?.media != null &&
                                        lastMessage!.media!.isNotEmpty
                                    ? "Media"
                                    : lastMessage?.text.toString(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: MyColors.grey,
                              fontSize: height * 0.014,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                ServicesUtils.formattedDate(lastMessage?.createdAt),
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: height * 0.013,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
