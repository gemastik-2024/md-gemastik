import 'package:get/get.dart';
import 'package:synaptaid/app/modules/community/bindings/community_binding.dart';
import 'package:synaptaid/app/modules/community/controllers/community_controller.dart';
import 'package:synaptaid/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<CommunityController>(
      () => CommunityController(),
    );
  }
}
