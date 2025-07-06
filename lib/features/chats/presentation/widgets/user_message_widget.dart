import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

class UserMessageWidget extends StatelessWidget {
  final MessageEntity messageEntity;
  const UserMessageWidget({super.key, required this.messageEntity});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Align(
      alignment: Alignment.bottomLeft,
      child :  IntrinsicWidth(
        child: Card(
            color: Color(0xFFFAF9F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.only(
                bottomRight: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r)
              )
              ,
            ),
            child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                     padding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                      horizontal: width * 0.03,
                    ),
                  child:
                      messageEntity.media != null && messageEntity.media!.isNotEmpty
                          ? Image.network(messageEntity.media!, fit: BoxFit.contain)
                          : Text(
                            messageEntity.text.toString(),
                            style: TextStyle(   overflow: TextOverflow.ellipsis,color: MyColors.black),
                          ),
                ),
                       Padding(
         padding: EdgeInsets.only(
                  bottom: height * 0.003,
                  right: width * 0.015,
                  left: width * 0.02,
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
               DateFormat('MMM d, yyyy • hh:mm a').format(messageEntity.createdAt),
                style: TextStyle(   overflow: TextOverflow.ellipsis,
                  color: MyColors.refresh,
                  fontSize: height * 0.011,
                  fontWeight: FontWeight.w600,
                ),
              ),


            ],
          ),
        ),
              ],
            ),
          ),
      ),
 
      
    );
  }
}
