import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselAnimation extends GetView<DashboardController> {
  CarouselAnimation({super.key});

  final List<String> imagePaths = [
    'assets/images/campaign.png',
    'assets/images/syndrom.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imagePaths.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    path,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              controller.sliderIndex.value = index;
            },
            height: 200.0,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enableInfiniteScroll: true,
            aspectRatio: 2.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagePaths.map((path) {
            int index = imagePaths.indexOf(path);
            return Obx(() => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.sliderIndex.value == index
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ));
          }).toList(),
        ),
      ],
    );
  }
}
