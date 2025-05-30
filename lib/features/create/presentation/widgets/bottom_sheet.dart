import 'package:flutter/material.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/core/widgets/bottom_modal_sheet.dart';

class BottomModalSheet {
  static Future<dynamic> show({
    required BuildContext context,
    required bool isDark,
    required String image,
    required String h1,
    required String h2,
    required GestureTapCallback cameraSourceTap,
    required GestureTapCallback gallerySourceTap,
  }) async {
    final height = UiUtils.screenHeight(context);
    final width = UiUtils.screenWidth(context);

    return await MyBottomModalSheet.show(
      context: context,
      isDark: isDark,
      builder: (context) {
        return SizedBox(
          height: height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      image,
                      height: height * 0.3,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: width * 0.92,
                      top: height * 0.01,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          size: height * 0.03,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025,
                    vertical: height * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        h1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: height * 0.03,
                        ),
                      ),
                      SizedBox(height: height * 0.003),
                      Text(
                        h2,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.grey,
                          fontSize: height * 0.017,
                        ),
                      ),
                    ],
                  ),
                ),
                StorySourceTile(
                  icon: Icons.camera_alt_outlined,
                  title: "Camera",
                  onTap: cameraSourceTap,
                ),
                StorySourceTile(
                  icon: Icons.image_outlined,
                  title: "Gallery",
                  onTap: gallerySourceTap,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StorySourceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final GestureTapCallback onTap;
  const StorySourceTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: UiUtils.screenHeight(context) * 0.035),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: UiUtils.screenHeight(context) * 0.020,
        ),
      ),
    );
  }
}
