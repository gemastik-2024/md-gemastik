import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/constans.dart';
import '../../../models/course.dart';

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

  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Keluar Aplikasi'),
            content: Text('Kamu ingin keluar aplikasi?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    textStyle: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                child: const Text('Ya'),
              ),
            ],
          ),
        ) ??
        false;
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
    {"icon": "assets/icons/clinic.png", "text": "Klinik"},
    {"icon": "assets/icons/school.png", "text": "Sekolah"},
    {"icon": "assets/icons/playground.png", "text": "Permainan"},
    {"icon": "assets/icons/parenting.png", "text": "Parenting"},
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

  @override
  void onInit() {
    driverEmail = '';
    driverName = '';
    super.onInit();
  }
}
