
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/constans.dart';
import '../../../../utils/size_config.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/carousel_animation.dart';
import 'widgets/fast_feature.dart';
import 'widgets/carousel.dart';
import 'widgets/menu.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key, this.scrollController});
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),  // Menentukan tinggi kustom untuk AppBar
        child: AppBar(
          backgroundColor: darkBlueColor,
          title: Center(
            child: Image.asset(
              'assets/illustrations/login.png',  // Ganti dengan path gambar yang Anda inginkan
              height: 500,  // Tentukan tinggi gambar
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const FastFeature(),
          const Menu(),
          const SizedBox(height: 5),
          const CarouselDashboard(),
          const SizedBox(height: 20),
          CarouselAnimation(),
        ],
      ),
    );
  }
}
