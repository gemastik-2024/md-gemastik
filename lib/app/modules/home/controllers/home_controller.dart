import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synaptaid/controllers/firebase_const.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Future<bool> checkIfSocioDemoGraphExists() async {
// BATAS SUCI
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
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
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
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
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
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
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
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
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
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

  // Tryna implementation new Navigation Floating Bar

  final currentPage = 0.obs;
  late TabController tabController;
  final List<Color> colors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
  ];

  @override
  void onInit() {
    currentPage.value = 0;
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    tabController.animation?.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage.value && isClosed) {
          changePage(value);
        }
      },
    );
    super.onInit();
  }

  void changePage(int newPage) {
    currentPage.value = newPage;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
