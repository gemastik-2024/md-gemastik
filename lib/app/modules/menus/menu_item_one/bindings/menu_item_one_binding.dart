import 'package:get/get.dart';

import '../controllers/menu_item_one_controller.dart';

class MenuItemOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuItemOneController>(
      () => MenuItemOneController(),
    );
  }
}
