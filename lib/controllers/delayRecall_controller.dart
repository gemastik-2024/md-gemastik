import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synaptaid/controllers/firebase_const.dart';

class DelayRecallController extends GetxController {
  RxList<String> wordList = <String>[].obs;
  RxList<String> recognizedWordsList = <String>[].obs;
  RxBool isListening = false.obs;
  RxBool starttest = true.obs;
  RxBool isMicEnabled = false.obs;
  RxString recognizedText = ''.obs;
  RxInt wordCount = 0.obs;
  RxString spokenSentence = 'Hold the button and start speaking'.obs;
  RxInt currentTrial = 1.obs;

  RxInt remainingSeconds = 60.obs;
  var timerDuration = const Duration(seconds: 60);

  void timeDuration() {
    remainingSeconds.value = timerDuration.inSeconds;
  }

  void decrementSeconds() {
    remainingSeconds.value--;
  }

  void enableMicButton() {
    isMicEnabled.value = true;
  }

  void disableMicButton() {
    isMicEnabled.value = false;
  }

  void incrementWordCount() {
    wordCount.value++;
  }

  void incrementTrial() {
    currentTrial.value++;
  }

  void saveData(int score) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        "DelayedRecall_test": {'DelayRecall_test_score': score}
      });
      debugPrint('Word list saved successfully');
    } catch (e) {
      debugPrint('Error saving word list: $e');
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
