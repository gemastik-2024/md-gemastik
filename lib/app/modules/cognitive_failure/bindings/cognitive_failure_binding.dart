import 'package:get/get.dart';

import '../controllers/cognitive_failure_controller.dart';

class CognitiveFailureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CognitiveFailureController>(
      () => CognitiveFailureController(),
    );
  }
}
