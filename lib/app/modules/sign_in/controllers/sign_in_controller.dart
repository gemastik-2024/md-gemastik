import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:synaptaid/utils/cache_manager.dart';

import '../../../../controllers/firebase_const.dart';

class SignInController extends GetxController with CacheManager {
  final formKey = GlobalKey<FormState>();
  final isPasswordVisible = false.obs;
  final isloading = false.obs;

  String email = '';
  String password = '';

  //////login
  Future<UserCredential?> logInMethod({email, password}) async {
    debugPrint('authSignup() called');
    UserCredential? userCredential;
    try {
      userCredential = await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        debugPrint('auth.signInWithEmailAndPassword() called');
        debugPrint('auth uid ${value.user!.uid}');
        debugPrint('auth uid ${value.user!.phoneNumber}');

        debugPrint('currentUser on sign_in controller: $currentUser');
        debugPrint(
            'currentUser on sign_in controller: ${GetStorage().read('uid')}');
        return value;
      });
    } on FirebaseAuthException catch (e) {
      debugPrint('LoginCalled() called Error "$e"');
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        Get.snackbar(
          'Error',
          'No user found for that email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        Get.snackbar(
          'Error',
          'Wrong password provided for that user.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'user-disabled') {
        debugPrint('User disabled.');
        Get.snackbar(
          'Error',
          'User disabled.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'too-many-requests') {
        debugPrint('Too many requests.');
        Get.snackbar(
          'Error',
          'Too many requests.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        debugPrint('Error: $e');
        Get.snackbar(
          'Error',
          'Error: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
    return userCredential;
  }

  Future<bool> logIn({password, email}) async {
    try {
      debugPrint('LogIn() called');
      UserCredential? userCredential =
          await logInMethod(email: email, password: password);

      if (userCredential == null) {
        debugPrint('userCredential is null');
        return false;
      }
      debugPrint("execute");
      saveUser(
        uid: userCredential.user!.uid,
        phone: userCredential.user!.phoneNumber,
        image: '',
      );
      return true;
    } catch (e) {
      debugPrint('Error: $e');
      Get.snackbar(
        'Error',
        'Error: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }
}
