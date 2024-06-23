import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        backgroundColor: darkBlueColor,
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
