import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  final currentPage = 0.obs;
  late PageController pageController;

  final List<Map<String, String>> onboardData = [
    {
    "heading": "Selamat Datang di Synaptaid",
    "text": "Synaptaid adalah solusi inovatif dengan kecerdasan buatan untuk mendukung perkembangan anak dengan disabilitas kognitif. Mari mulai perjalanan menuju potensi penuh mereka!",
    "image": "assets/illustrations/onboarding1.png"
  },
  {
    "heading": "Personalisasi yang Unik",
    "text": "Setiap anak itu istimewa. Synaptaid menghadirkan profil yang dipersonalisasi, konten edukasi, dan latihan keterampilan hidup sesuai kebutuhan mereka.",
    "image": "assets/illustrations/onboarding2.png"
  },
  {
    "heading": "Kemajuan Terukur",
    "text": "Pantau dan rayakan setiap pencapaian anak Anda. Fitur pelacakan kemajuan dan gamifikasi membuat belajar menjadi menyenangkan dan memotivasi.",
    "image": "assets/illustrations/onboarding3.png"
  },
  {
    "heading": "Dukungan Komunitas",
    "text": "Libatkan keluarga, pendidik, dan profesional kesehatan dalam satu platform inklusif. Bersama-sama, kita menciptakan lingkungan yang suportif.",
    "image": "assets/illustrations/onboarding4.png"
  },
  {
    "heading": "Teknologi Inovatif",
    "text": "Dengan antarmuka yang intuitif dan alat ukur yang valid, Synaptaid mendukung pendidikan, perkembangan, dan kesejahteraan anak-anak di seluruh Indonesia.",
    "image": "assets/illustrations/onboarding5.png"
  },
  {
    "heading": "Mulai Sekarang",
    "text": "Bergabunglah dengan Synaptaid dan bantu anak-anak mencapai potensi penuh mereka. Unduh aplikasinya dan mulai petualangan baru hari ini!",
    "image": "assets/illustrations/onboarding6.png"
  },
  ];

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
