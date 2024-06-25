import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

mixin CacheManagedr {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write('token', token);
    return true;
  }

  Future saveUser({
    required String uid,
  }) async {
    final box = GetStorage();
    await box.write('uid', uid);
  }

  Future removeUser() async {
    final box = GetStorage();
    await box.remove('uid');
  }

  String? getUserId() {
    final box = GetStorage();
    return box.read('uid');
  }

  String? getFullname() {
    final box = GetStorage();
    return box.read('fullname');
  }

  String? getPhone() {
    final box = GetStorage();
    return box.read('phone');
  }

  String? getToken() {
    final box = GetStorage();
    return box.read('token');
  }

  String? getImage() {
    final box = GetStorage();
    return box.read('image');
  }
}
