import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:synaptaid/controllers/firebase_const.dart';

class HomeScreenController extends GetxController {
  Future<bool> checkIfSocioDemoGraphExists() async {
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
}
