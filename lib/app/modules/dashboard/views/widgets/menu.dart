import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/app/modules/dashboard/views/widgets/category_card.dart';
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
              (index) => CategoryCard(
                icon: controller.categories[index]["icon"],
                text: controller.categories[index]["text"],
                press: () {
                  final String route = controller.categories[index]["text"]
                      .toString()
                      .toLowerCase();
                  debugPrint("/$route");
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
              (index) => CategoryCard(
                icon: controller.categorize[index]["icon"],
                text: controller.categorize[index]["text"],
                press: () {
                  final String route = controller.categorize[index]["text"]
                      .toString()
                      .toLowerCase();
                  debugPrint("/$route");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
