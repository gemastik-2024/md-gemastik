import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingContents extends StatelessWidget {
  const OnBoardingContents({
    Key? key,
    this.text,
    this.image,
    this.heading,
  }) : super(key: key);
  final String? text, image, heading;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Column(
      children: <Widget>[
        Text(
          heading!,
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
            color: Colors.blue,
          ),
        ),
        Image.asset(
          image!,
          height: height * 0.35,
          // width: width * 0.8,
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Text(
          text!,
          style: GoogleFonts.nunito(),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
