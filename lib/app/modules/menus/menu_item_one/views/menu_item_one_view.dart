// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/menu_item_one_controller.dart';

class MenuItemOneView extends GetView<MenuItemOneController> {
  String? text = Get.arguments[0]["text"];
  MenuItemOneView({
    super.key,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MenuItemOneView'),
        centerTitle: true,
      ),
      body: Center(
        child: Center(
          child: Text(
            'MenuItemOneView is $text',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
