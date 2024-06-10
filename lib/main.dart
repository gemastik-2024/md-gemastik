import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'views/on_boarding_screens/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => debugPrint('Firebase initialized in main.dart'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //
    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'CogQuest',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const OnBoardingPage(),
    //   // home: const AnimalNameGuessScreen(),
    // );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CogQuest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
