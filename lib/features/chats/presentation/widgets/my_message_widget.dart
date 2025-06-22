import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/chats/domain/entities/message_entity.dart';

class MyMessageWidget extends StatelessWidget {
  final MessageEntity messageEntity;
  const MyMessageWidget({super.key, required this.messageEntity});

  @override
  Widget build(BuildContext context) {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);
    return Align(
      alignment: Alignment.bottomRight,
      child: IntrinsicWidth(
        child: Card(
          color: MyColors.secondaryDense,
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r)
              )
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
                          style: TextStyle(color: MyColors.white),
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
                      DateFormat(
                        'MMM d, yyyy • hh:mm a',
                      ).format(messageEntity.createdAt),
                      style: TextStyle(
                        color: MyColors.secondaryGrey,
                        fontSize: height * 0.012,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: width * 0.012),
                    Icon(
                   messageEntity.isSeenByOther ?   Icons.done_all : Icons.done,
                      size: height * 0.019,
                      color: MyColors.secondaryGrey,
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
