import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/size_config.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getScreenWidth(60),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getScreenWidth(5)),
              height: getScreenWidth(70),
              width: getScreenWidth(70),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 234, 234),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: const Color.fromARGB(255, 226, 233, 239),
                    width: 1,
                  )),
              child: Image.asset(
                icon!,
                height: 100,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              text!,
              style: GoogleFonts.nunito(
                color: const Color.fromARGB(255, 113, 113, 113),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
