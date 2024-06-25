import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/course.dart';
import '../../../routes/app_pages.dart';

class DashboardController extends GetxController {
  String name = '', email = '', uid = '', userType = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final status = false.obs;
  late Course course;

  String? profileImage,
      docId,
      driverEmail = '',
      driverName = '',
      driverUid = '';

  getDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userType = prefs.getString('userType')!;

    await FirebaseFirestore.instance
        .collection(userType == 'Doctors' ? 'Doctors' : 'Parents')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      driverName = value.docs[0]['name'];
      driverEmail = value.docs[0]['email'];
      driverUid = _auth.currentUser!.uid;
    });
  }

  final exploreCourses = <Course>[
    Course(
      courseTitle: "Skrining Autisme",
      courseSubtitle:
          "Test berdasarkan studi kasus yang kami buat dari survey MCHAT dengan keakuratan sangat baik",
      background: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromRGBO(218, 218, 218, 1),
        ],
      ),
      illustration: 'illustration-04.png',
    ),
  ];
  List<Map<String, dynamic>> categories = [
    {
      "icon": "assets/icons/socio-demographi-data.png",
      "text": "Demografi Sosial",
      "route": "socio-demographic",
    },
    {
      "icon": "assets/icons/school.png",
      "text": "Cog-Games",
      "route": Routes.COGNITIVE_GAMES,
    },
    {
      "icon": "assets/icons/playground.png",
      "text": "Permainan",
    },
    {
      "icon": "assets/icons/parenting.png",
      "text": "Parenting",
    },
  ];

  List<Map<String, dynamic>> categorize = [
    {"icon": "assets/icons/training.png", "text": "Pelatihan"},
    {"icon": "assets/icons/event.png", "text": "Event"},
    {"icon": "assets/icons/forum.png", "text": "Forum"},
    {"icon": "assets/icons/charity.png", "text": "Donasi"},
  ];

  final campaignIndex = 0.obs;

  final List<String> imagePaths = [
    'assets/images/campaign.png',
    'assets/images/syndrom.png',
  ];

  // BATAS SUCI

  // final String userId = GetStorage().read('uid');

  final box = GetStorage();
  late String userId;

  final userPhone = GetStorage().read('phone').toString();

  Future<bool> checkIfSocioDemoGraphExists() async {
// BATAS SUCI
//uid belum benar
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    if (userDoc.exists && userData != null) {
      List<dynamic> pagesArray = userData['pages'] ?? [];
      if (pagesArray.contains('socio_demographic') == false) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<bool> checkIfMedicalHistoryExists() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    if (userDoc.exists && userData != null) {
      List<dynamic> pagesArray = userData['pages'] ?? [];
      if (pagesArray.contains('medical_history') == false) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<bool> checkIfCovidExperienceExists() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    if (userDoc.exists && userData != null) {
      List<dynamic> pagesArray = userData['pages'] ?? [];
      if (pagesArray.contains('covid_experience') == false) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<bool> checkIfInitialIllnessExists() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    if (userDoc.exists && userData != null) {
      List<dynamic> pagesArray = userData['pages'] ?? [];
      if (pagesArray.contains('symptoms_initial_illness') == false) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<bool> checkIfCognitiveExists() async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    if (userDoc.exists && userData != null) {
      List<dynamic> pagesArray = userData['pages'] ?? [];
      if (pagesArray.contains('survey_results') == false) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  final sliderIndex = 0.obs;

  @override
  void onInit() {
    userId = box.read('uid') ?? 'nulls';
    driverEmail = '';
    driverName = '';
    super.onInit();
  }

  void functionMenuItem(String route) {
    switch (route) {
      case 'socio-demographic':
        socioDemographiCase();
        break;
      case 'school':
        debugPrint("SIUU");
        break;
      case 'playground':
        break;
    }
  }

  void socioDemographiCase() async {
    try {
      if (await checkIfSocioDemoGraphExists() != true) {
        Get.offAllNamed(Routes.SOCIO_DEMOGRAPHIC);
      } else {
        Get.snackbar(
          'Perhatian!',
          'Anda sudah mengisi form ini!',
          titleText: const Text(
            'Perhatian!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade500,
          colorText: Colors.white,
          snackStyle: SnackStyle.FLOATING,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan, silahkan coba lagi!',
        titleText: const Text(
          'Attention!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }
}
