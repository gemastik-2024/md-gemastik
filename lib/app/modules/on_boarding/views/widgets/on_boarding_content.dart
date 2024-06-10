import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/on_boarding_controller.dart';

class OnBoardingContent extends GetWidget<OnBoardingController> {
  OnBoardingContent({
    super.key,
    required this.image,
    required this.text,
    required this.heading,
  });
  final String image;
  final String text;
  final String heading;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Column(
      children: <Widget>[
        Text(
          heading,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 32,
              ),
        ),
        Container(
          width: 85,
          height: 4,
          margin: const EdgeInsets.only(bottom: 25),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: Colors.deepPurple,
          ),
        ),
        Image.asset(
          image,
          height: height * 0.35,
          // width: width * 0.8,
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Text(
          text,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}