import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/app/routes/app_pages.dart';

import '../../../../controllers/firebase_const.dart';
import '../../../../controllers/sociodemographic_controller.dart';
import '../../../../views/medicalhistory_sceen.dart';

class SocioDemographicController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Create an instance of the controller
  final DemographicController _controller = Get.put(DemographicController());
  bool isloading = false;

  final name = ''.obs;
  final gender = 'Male'.obs;
  final age = '18-25 years'.obs;
  final residence = 'Rural'.obs;
  final education = 'Matriculation (grade 9 and 10)'.obs;
  final profession = ''.obs;

  void submitForm(
      {name,
      gender,
      age,
      residence,
      education,
      profession,
      password,
      email}) async {
    debugPrint('submitForm() called');
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .set({
        'pages': FieldValue.arrayUnion(['socio_demographic']),
      }, SetOptions(merge: true));
      ////storing data of user in firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        'socio_demographic': {
          'name': name,
          'gender': gender,
          'age': age,
          'residence': residence,
          'education': education,
          'profession': profession,
          'id': currentUser!.uid,
        }
      }).then((value) => Get.offAllNamed(Routes.MEDICAL_HISTORY));
    } catch (e) {
      debugPrint('LoginCalled() called Error "$e"');
      Get.snackbar(
        'Error',
        'Some Error Occured! ',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
