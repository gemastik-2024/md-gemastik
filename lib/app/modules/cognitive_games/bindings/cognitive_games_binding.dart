import 'package:get/get.dart';

import '../controllers/cognitive_games_controller.dart';

class CognitiveGamesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CognitiveGamesController>(
      () => CognitiveGamesController(),
    );
  }
}
