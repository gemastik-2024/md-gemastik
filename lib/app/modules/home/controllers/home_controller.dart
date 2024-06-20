import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synaptaid/app/modules/dashboard/views/dashboard_view.dart';
import 'package:synaptaid/app/modules/home/views/home_view.dart';
import 'package:synaptaid/controllers/firebase_const.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final FirebaseAuth auth = FirebaseAuth.instance;

  final selectedIndex = 0.obs;

  List<Widget> pages = [
    DashboardView(),
    HomeView(),
    //HomeScreen(),
    //ConsultScreen(),
    //ChatScreenBot(),
    //BehaviorDictionaryPage(),
    // ProfileScreen(),
  ];

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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}
