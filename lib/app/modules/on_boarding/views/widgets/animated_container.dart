import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/on_boarding_controller.dart';

class AnimatedContainerWidget extends GetWidget<OnBoardingController> {
  const AnimatedContainerWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 5),
        height: 6,
        width: controller.currentPage.value == index ? 40 : 15,
        decoration: BoxDecoration(
          color: controller.currentPage.value == index
              ? Colors.deepPurple
              : Colors.grey,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
