
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/constants/constans.dart';

import 'vigilance_test_screen.dart';
import 'package:synaptaid/controllers/digitspan_controller.dart';

class BackwardDigitSpan extends StatefulWidget {
  final int? ForwardScore;

  BackwardDigitSpan({
    Key? key,
    this.ForwardScore,
  }) : super(key: key);

  @override
  State<BackwardDigitSpan> createState() => _BackDigitState();
}

class _BackDigitState extends State<BackwardDigitSpan> {
  late SharedPreferences sf;
  SpeechToText speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  final DigitSpanController _controller = Get.put(DigitSpanController());
  int score = 0;
  var numbers = ['7', '4', '2'];
  bool isTimerStarted = false;
  bool innNextScreen = false;

  @override
  void initState() {
    super.initState();
    initializeSharedPref();
  }

  void initializeSharedPref() async {
    sf = await SharedPreferences.getInstance();
  }

  void _startTest() {
    isTimerStarted = true;
    _controller.timeDuration();
    _countdownTimer();
    _speakNumbers();
  }

  void _countdownTimer() async {
    while (_controller.remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      _controller.decrementSeconds();
    }
    isTimerStarted = false;
    if (!innNextScreen) {
      nextTest();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.remainingSeconds;
  }

  void _speakNumbers() async {
    _controller.isReading.value = true;
    for (var number in numbers) {
      await flutterTts.speak(number);
      await Future.delayed(const Duration(seconds: 2));
    }
    _controller.isReading.value = false;
  }

  Future<void> nextTest() async {
    int score = _controller.getScore();
    score += widget.ForwardScore!;

    await _controller.updateScore(score);
    sf.setInt('nextGame', 8);
    innNextScreen = true;
    _controller.remainingSeconds.value = 0;
    Get.offAll(() => const VigilanceScreen());
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _controller.isListening.value,
        endRadius: 75,
        duration: const Duration(milliseconds: 2000),
        glowColor: darkBlueColor,
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!_controller.isListening.value &&
                !_controller.isReading.value &&
                !_controller.starttest.value &&
                isTimerStarted) {
              var available = await speechToText.initialize();
              if (available) {
                _controller.isListening.value = true;
                speechToText.listen(
                  onResult: (result) {
                    _controller.text.value = result.recognizedWords;
                    var recognizedWords =
                        _controller.text.replaceAll('', ' ').split(' ');
                    var numbersJoined = numbers.join('');
                    if (recognizedWords.join('') == numbersJoined) {
                      score++;
                      _controller.incrementScore();
                    }
                  },
                );
              }
            }
          },
          onDoubleTap: () {
            if (_controller.starttest.value) {
              _controller.starttest.value = false;
              _startTest();
            }
          },
          onTapUp: (details) {
            if (!_controller.starttest.value && _controller.isReading.isFalse) {
              _controller.isListening.value = false;
              speechToText.stop();
              Future.delayed(const Duration(seconds: 3), () {
                nextTest();
              });
            }
          },
          child: Obx(
            () => CircleAvatar(
              backgroundColor: _controller.starttest.value
                  ? darkBlueColor
                  : _controller.isReading.value
                      ? Colors.grey
                      : darkBlueColor,
              radius: 40,
              child: Obx(
                () => Icon(
                  _controller.starttest.value
                      ? Icons.double_arrow_rounded
                      : Icons.mic,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Tes Perhatian',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkBlueColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rentang Mundur',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => Text(
                    '${_controller.remainingSeconds}',
                    style:  GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBlueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 5.0, left: 16.0, bottom: 16.0, right: 12.0),
            child: Text(
              'Sekarang akan dibacakan daftar angka lain, tapi kali ini Anda harus mengulanginya dalam urutan terbalik.',
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: darkBlueColor,
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          const Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: darkBlueColor,
          ),
          SizedBox(height: height * 0.1),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                margin: const EdgeInsets.only(bottom: 150),
                child: Obx(
                  () => Text(
                    _controller.starttest.value
                        ? "Ketuk dua kali tombol untuk memulai tes"
                        : _controller.text.value,
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: _controller.isListening.value
                          ? darkBlueColor
                          : Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
