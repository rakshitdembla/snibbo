import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';

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

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? MyColors.darkPrimary : MyColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      isDismissible: true,
      builder: (context) {
        return SizedBox(
          height: height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                  child: Stack(
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
                      SizedBox(height: height * 0.004),
                      Text(
                        h2,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: MyColors.grey,
                          fontSize: height * 0.018,
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
          fontSize: UiUtils.screenHeight(context) * 0.021,
        ),
      ),
    );
  }
}
