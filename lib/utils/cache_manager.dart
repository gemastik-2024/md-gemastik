import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write('token', token);
    return true;
  }

  Future saveUser({
    required String uid,
    // required String fullname,
    required String? phone,
    required String image,
  }) async {
    final box = GetStorage();
    await box.write('uid', uid);
    // await box.write('fullname', fullname);
    await box.write('phone', phone);
    await box.write('image', image);
    debugPrint("SUCCESS");
  }

  Future removeUser() async {
    final box = GetStorage();
    await box.remove('uid');
    await box.remove('phone');
    await box.remove('image');
  }

  int? getUserId() {
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

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove('id');
    await box.remove('fullname');
    await box.remove('phone');
    await box.remove('token');
    await box.remove('image');
  }
}
