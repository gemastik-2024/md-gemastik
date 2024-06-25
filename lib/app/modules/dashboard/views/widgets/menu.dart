import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/app/modules/dashboard/views/widgets/menu_item.dart';
import 'package:synaptaid/app/routes/app_pages.dart';
import '../../../../../utils/size_config.dart';
import '../../controllers/dashboard_controller.dart';

class Menu extends GetView<DashboardController> {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getScreenWidth(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              controller.categories.length,
              (index) => MenuItem(
                icon: controller.categories[index]["icon"],
                text: controller.categories[index]["text"],
                route: controller.categories[index]["route"],
                press: () {
                  final String route = controller.categories[index]["route"]
                      .toString()
                      .toLowerCase();
                  controller.functionMenuItem(route);
                  // Get.toNamed('/$route');
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              controller.categorize.length,
              (index) => MenuItem(
                icon: controller.categorize[index]["icon"],
                text: controller.categorize[index]["text"],
                route: controller.categorize[index]["route"],
                press: () {
                  final String route = controller.categories[index]["text"]
                      .toString()
                      .toLowerCase();
                  debugPrint("/$route");
                  Get.toNamed(Routes.MENU_ITEM_ONE, arguments: [
                    {'text': route}
                  ]);
                  // Get.toNamed('/$route');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
