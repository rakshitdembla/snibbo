import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snibbo_app/core/theme/mycolors.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snibbo_app/test_list.dart';

@RoutePage()
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  FocusNode searchNode = FocusNode();
  final testList = TestList.test();

  @override
  Widget build(BuildContext context) {
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.0050),
          child: NestedScrollView(
            headerSliverBuilder:
                (context, isScrolled) => [
                  SliverAppBar(
                    title: ListTile(
                      minTileHeight: height * 0.04,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      dense: true,
                      leading: Icon(
                        Icons.search_outlined,
                        color: MyColors.black,
                      ),
                      title: Text(
                        "Search",
                        style: TextStyle(
                          color: MyColors.grey,
                          fontSize: height * 0.02,
                        ),
                      ),
                      tileColor: const Color.fromARGB(49, 161, 161, 161),
                    ),
                  ),
                ],
            body: MasonryGridView.builder(
              crossAxisSpacing: width * 0.0050,
              mainAxisSpacing: width * 0.0050,
              itemCount: testList.length,

              itemBuilder: (context, index) {
                return Image.asset(testList[index], fit: BoxFit.cover);
              },
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
