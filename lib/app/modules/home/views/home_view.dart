import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:synaptaid/app/modules/community/views/community_view.dart';
import 'package:synaptaid/app/modules/dashboard/views/dashboard_view.dart';
import 'package:synaptaid/app/modules/settings/views/settings_view.dart';
import '../../../../constants/constans.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final Color unselectedColor =
        controller.colors[controller.currentPage.value].computeLuminance() < 0.5
            ? Colors.black
            : Colors.white;
    final Color unselectedColorReverse =
        controller.colors[controller.currentPage.value].computeLuminance() < 0.5
            ? Colors.white
            : Colors.black;

    return SafeArea(
      child: Scaffold(
        body: BottomBar(
          clip: Clip.none,
          fit: StackFit.expand,
          icon: (width, height) => Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: null,
              icon: Icon(
                Icons.arrow_upward_rounded,
                color: unselectedColor,
                size: width,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          showIcon: true,
          width: MediaQuery.of(context).size.width * 0.8,
          barColor: controller.colors[controller.currentPage.value]
                      .computeLuminance() >
                  0.5
              ? darkBlueColor
              : Colors.white,
          start: 2,
          end: 0,
          offset: 10,
          barAlignment: Alignment.bottomCenter,
          iconHeight: 30,
          iconWidth: 30,
          reverse: false,
          hideOnScroll: true,
          scrollOpposite: false,
          onBottomBarHidden: () {},
          onBottomBarShown: () {},
          body: (context, ctrl) => TabBarView(
            controller: controller.tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              DashboardView(scrollController: ctrl),
              CommunityView(scrollController: ctrl),
              DashboardView(scrollController: ctrl),
              SettingsView(scrollController: ctrl),
            ],
          ),
          child: Obx(() => TabBar(
                onTap: (index) {
                  controller.currentPage.value = index;
                },
                tabAlignment: TabAlignment.fill,
                indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                controller: controller.tabController,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: controller.currentPage <= 4
                          ? controller.colors[controller.currentPage.value]
                          : unselectedColor,
                      width: 4,
                    ),
                    insets: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
                tabs: [
                  SizedBox(
                    height: 55,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.home,
                        color: controller.currentPage.value == 0
                            ? controller.colors[0]
                            : unselectedColor,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 55,
                      width: 40,
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: controller.currentPage.value == 1
                              ? controller.colors[3]
                              : unselectedColor,
                        ),
                      )),
                  SizedBox(
                    height: 55,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.search,
                        color: controller.currentPage.value == 2
                            ? controller.colors[1]
                            : unselectedColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.settings,
                        color: controller.currentPage.value == 3
                            ? controller.colors[4]
                            : unselectedColor,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
