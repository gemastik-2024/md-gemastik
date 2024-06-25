import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synaptaid/views/test/abstraction_screen.dart';
import 'package:synaptaid/views/test/delayRecall_test_screen.dart';
import 'package:synaptaid/views/test/orientation_screen.dart';

import '../../../../views/animal_name_screen.dart';
import '../../../../views/test/backward_test_screen.dart';
import '../../../../views/test/connecting_dot_screen.dart';
import '../../../../views/test/cube_drawing_test_screen.dart';
import '../../../../views/test/forward_test_screen.dart';
import '../../../../views/test/memory_test_screen.dart';
import '../../../../views/test/sentence_repetition_screen.dart';
import '../../../../views/test/serial7_test_screen.dart';
import '../../../../views/test/verbalfluency_test_screen.dart';
import '../../../../views/test/vigilance_test_screen.dart';
import '../../../../views/test/visuospatial_clock_test_screen.dart';

class CognitiveGamesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    SharedPreferences.getInstance().then((prefs) {
      unlockedGames.value = prefs.getInt('nextGame') ?? 1;
    });
  }

  late RxInt gameNumber;
  late RxInt unlockedGames = 1.obs;

  void playGame(int gameNumber, BuildContext context) {
    if (gameNumber == unlockedGames.value) {
      switch (gameNumber) {
        case 1:
          Get.offAll(() => const ConnectingDotsScreen());
          break;
        case 2:
          Get.offAll(() => const DrawingScreen());
          break;
        case 3:
          Get.offAll(() => const ClockTestScreen());
          break;
        case 4:
          Get.offAll(() => const AnimalNameGuessScreen());
          break;
        case 5:
          Get.offAll(() => const MemoryTestScreen());
          break;
        case 6:
          Get.offAll(() => const ForwardDigitSpan());
          break;
        case 7:
          Get.offAll(() => BackwardDigitSpan());
          break;
        case 8:
          Get.offAll(() => const VigilanceScreen());
          break;
        case 9:
          Get.offAll(() => const Serial7Screen());
        case 10:
          Get.offAll(() => const SentenceRepetitionScreen());
          break;
        case 11:
          Get.offAll(() => const VocabularyScreen());
          break;
        case 12:
          Get.offAll(() => const AbstractionScreen());
          break;
        case 13:
          Get.offAll(() => const DelayRecallScreen());
        case 14:
          Get.offAll(() => const OrientationScreen());
          break;
      }
    } else {
      // Show a message that the game is locked
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Game Locked'),
          content: Text('You need to complete Game $unlockedGames  first.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  final gameNameList = [
    'Connecting Dots',
    'Drawing Test',
    'Clock Test',
    'Guess Animal Name',
    'Memory Test',
    'Forward Digit Span',
    'Backward Digit Span',
    'Vigilance',
    'Serial 7',
    'Sentence Repetition',
    'Vocabulary Test',
    'Abstraction',
    'Delay Recall',
    'Orientation',
  ];
}
