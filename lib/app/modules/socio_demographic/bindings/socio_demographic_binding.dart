import 'package:get/get.dart';

import '../controllers/socio_demographic_controller.dart';

class SocioDemographicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocioDemographicController>(
      () => SocioDemographicController(),
    );
  }
}
