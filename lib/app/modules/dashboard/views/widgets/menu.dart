import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/app/modules/dashboard/views/widgets/category_card.dart';

import '../../../../../utils/size_config.dart';
import '../../../../../views/sociodemographic_sceen.dart';
import '../../controllers/dashboard_controller.dart';

class Menu extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/clinic.png", "text": "Klinik"},
      {"icon": "assets/icons/school.png", "text": "Sekolah"},
      {"icon": "assets/icons/playground.png", "text": "Permainan"},
      {"icon": "assets/icons/parenting.png", "text": "Parenting"},
    ];

    List<Map<String, dynamic>> categorize = [
      {"icon": "assets/icons/training.png", "text": "Pelatihan"},
      {"icon": "assets/icons/event.png", "text": "Event"},
      {"icon": "assets/icons/forum.png", "text": "Forum"},
      {"icon": "assets/icons/charity.png", "text": "Donasi"},
    ];
    return Padding(
      padding: EdgeInsets.all(getScreenWidth(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () async {
                  try {
                    if (await controller.checkIfSocioDemoGraphExists() !=
                        false) {
                      Get.offAll(() => const SocioDemographicScreen());
                    } else {
                      Get.snackbar(
                        'Attention!',
                        'The Form is already Filled!',
                        titleText: const Text(
                          'Attention!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green.shade500,
                        colorText: Colors.white,
                        snackStyle: SnackStyle.FLOATING,
                      );
                    }
                  } catch (e) {
                    Get.snackbar(
                      'Attention!',
                      '$e',
                      titleText: const Text(
                        'Attention!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red.shade500,
                      colorText: Colors.white,
                      snackStyle: SnackStyle.FLOATING,
                    );
                  }
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
              categorize.length,
              (index) => CategoryCard(
                icon: categorize[index]["icon"],
                text: categorize[index]["text"],
                press: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
