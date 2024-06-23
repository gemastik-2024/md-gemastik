import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants/constans.dart';
import '../../../../../utils/size_config.dart';
import '../../controllers/dashboard_controller.dart';

class CarouselDashboard extends GetView<DashboardController> {
  const CarouselDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(
        context); // Initialize SizeConfig before using screenWidth and screenHeight
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Campaign",
                style: GoogleFonts.nunito(
                    color: darkBlueColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 24),
              ),
              const SizedBox(height: 6),
              Text(
                "Saling peduli untuk memahami mereka lebih dalam",
                style: GoogleFonts.nunito(
                    color: Colors.blueGrey[400], fontSize: 16),
              ),
            ],
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    offset: Offset(0, 4),
                    color: Colors.black54,
                  )
                ],
                color: const Color(0xffA295FD),
                borderRadius: BorderRadius.circular(5)),
          )
        ],
      ),
    );
  }
}
