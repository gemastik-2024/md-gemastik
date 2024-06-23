
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/app/modules/on_boarding/controllers/on_boarding_controller.dart';
import 'package:synaptaid/constants/constans.dart';

class OnBoardingContent extends GetWidget<OnBoardingController> {
  const OnBoardingContent({
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
          style: GoogleFonts.nunito(
            color: darkBlueColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        Container(
          width: 85,
          height: 4,
          margin: const EdgeInsets.only(bottom: 25),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: darkBlueColor,
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
          style: GoogleFonts.sora(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}