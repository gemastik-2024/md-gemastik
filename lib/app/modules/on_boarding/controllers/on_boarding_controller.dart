import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  final currentPage = 0.obs;
  late PageController pageController;

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

  final List<Map<String, String>> onboardData = [
    {
      'text': "Welcome to CogQuest.",
      'image': 'assets/illustrations/onboarding1.png',
      'heading': 'Welcome'
    },
    {
      'text':
          "Here, you can find out what your cognitive strengths are, track your progress, and get personalised recommendations to improve your faculties, all the while contributing to the latest brain research.",
      'image': 'assets/illustrations/onboarding2.jpg',
      'heading': 'Introduction'
    },
    {
      'text':
          "Currently, we are researching the impact of Long COVID on memory and cognition. To become a part of this research, and test your cognitive abilities, please sign up.",
      'image': 'assets/illustrations/onboarding3.jpg',
      'heading': 'Jump In'
    },
  ];
}
