import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pro_image_editor/core/platform/io/io_helper.dart';
import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:snibbo_app/core/widgets/user_circular_profile_widget.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

@RoutePage()
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    socket_io.Socket socket = socket_io.io(
      ApiMainUrl.baseUrl,
      socket_io.OptionBuilder().setTransports(['websocket']).enableAutoConnect().build(),
    );

    socket.onConnect((_) {
      debugPrint('🟢 Connected: ${socket.id}');
    });

  socket.onConnectError((data) {
  debugPrint("❌ Connect Error: $data");
});

socket.onError((data) {
  debugPrint("❌ Error: $data");
});

socket.onDisconnect((_) {
  debugPrint("🔴 Disconnected from socket");
});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
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
        child: ListView.builder(
          padding: EdgeInsets.only(top: height * 0.007),
          itemCount: 15,
          itemBuilder: (context, index) {
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
                            profileUrl: "",
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
                                  "rakshitdembla",
                                  style: TextStyle(
                                    fontSize: height * 0.016,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: height * 0.004),
                                Text(
                                  "Hey!!!!!!",
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
                            "17:55",
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
        ),
      ),
    );
  }
}

ActionPane _buildActionPane(BuildContext context) {
  return ActionPane(
    motion: const ScrollMotion(),
    children: [
      SlidableAction(
        onPressed: (ctx) {},
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: Icons.push_pin,
        label: 'Pin',
      ),
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
