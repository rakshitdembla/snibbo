import 'package:flutter/material.dart';
import 'package:snibbo_app/core/network/web_sockets/web_sockets_services.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/service_locator.dart';

class ChatScreenAppbarUserinfo extends StatelessWidget {
  final bool isOnline;
  final String? lastSeen;
  final String username;
  final String? chatId;
  const ChatScreenAppbarUserinfo({
    super.key,
    required this.isOnline,
    required this.username,
    required this.lastSeen,
    this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: TextStyle(   overflow: TextOverflow.ellipsis,
              fontSize: height * 0.016,
              color: MyColors.white,
            ),
          ),
          SizedBox(height: height * 0.004),
          StreamBuilder(
            stream: sl<WebSocketsServices>().socketStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final event = snapshot.data;
                final isTyping = event?["type"] == "typing";
                final isStoppedTyping = event?["type"] == "stop-typing";
                final isSameRoom = event?["data"] == chatId;

                if (isTyping && isSameRoom) {
                  return Text(
                    "Typing...",
                    style: TextStyle(   overflow: TextOverflow.ellipsis,
                      color: MyColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: height * 0.013,
                    ),
                  );
                } else if (isStoppedTyping && isSameRoom) {
                  return Text(
                    isOnline
                        ? "🟢 Online "
                        : lastSeen != null && lastSeen!.isNotEmpty
                        ? "last seen $lastSeen"
                        : "",
                    style: TextStyle(   overflow: TextOverflow.ellipsis,
                      color: MyColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: height * 0.013,
                    ),
                  );
                }
              }
              return Text(
                isOnline
                    ? "🟢 Online "
                    : lastSeen != null && lastSeen!.isNotEmpty
                    ? "last seen $lastSeen"
                    : "",
                style: TextStyle(   overflow: TextOverflow.ellipsis,
                  color: MyColors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: height * 0.013,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
