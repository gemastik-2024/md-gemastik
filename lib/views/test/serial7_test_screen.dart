
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/serial7test_controller.dart';
import 'sentence_repetition_screen.dart';

class Serial7Screen extends StatefulWidget {
  const Serial7Screen({Key? key}) : super(key: key);

  @override
  State<Serial7Screen> createState() => _Serial7State();
}

class _Serial7State extends State<Serial7Screen> {
  late SharedPreferences sf;
  SpeechToText speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  final Serial7Controller _controller = Get.put(Serial7Controller());
  int score = 0;
  RxInt attempts = 0.obs;
  RxInt maxAttempts = 5.obs;
  int target = 93;
  bool isTimerStarted = false;
  bool alert = false;

  void _countdownTimer() async {
    while (_controller.remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      _controller.decrementSeconds();
    }
    isTimerStarted = false;
    if (!alert) {
      _showPopup();
    }
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPref();
  }

  void initializeSharedPref() async {
    sf = await SharedPreferences.getInstance();
  }

  void _startTest() {
    if (!isTimerStarted) {
      isTimerStarted = true;
      _controller.timeDuration();
      _countdownTimer();
    }
  }

  Future<void> finalScore() async {
    int finalScore;
    if (score > 3) {
      finalScore = 3;
    } else if (score == 2 || score == 3) {
      finalScore = 2;
    } else if (score == 1) {
      finalScore = 1;
    } else {
      finalScore = 0;
    }
    _controller.saveScore(finalScore);
  }

  Future<void> _validateCounting() async {
    var recognizedNumber = int.tryParse(_controller.text.value);
    if (recognizedNumber != null) {
      if (recognizedNumber == target) {
        attempts++;
        score++;
        if (attempts.value == maxAttempts.value) {
          await finalScore();
          Future.delayed(const Duration(seconds: 3), () {
            _showPopup();
          });
          _controller.isListening.value = false;
          _controller.maxAttemptsReached.value = true;
        } else {
          _speakTarget();
        }
        target = target - 7;
      } else {
        attempts++;
        if (attempts.value == maxAttempts.value) {
          await finalScore();
          Future.delayed(const Duration(seconds: 3), () {
            _showPopup();
          });
          _controller.isListening.value = false;
          _controller.maxAttemptsReached.value = true;
        }
      }
    }
  }

  void _speakTarget() async {
    await flutterTts.speak("Hitung mundur dari $target");
  }

  void _showPopup() {
    alert = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tes Selesai'),
          content: const Text(
              'Selamat! Anda telah menyelesaikan Tes Perhatian.'),
          actions: [
            TextButton(
              onPressed: () {
                sf.setInt('nextGame', 10);
                Navigator.of(context).pop();
                Get.offAll(() => const SentenceRepetitionScreen());
              },
              child: const Text('Selanjutnya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _controller.isListening.value,
        endRadius: 75,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.blue,
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!_controller.isListening.value &&
                !_controller.maxAttemptsReached.value &&
                _controller.starttest.value) {
              var available = await speechToText.initialize();
              if (available) {
                _controller.isListening.value = true;
                speechToText.listen(
                  onResult: (result) {
                    _controller.text.value = result.recognizedWords;
                    _validateCounting();
                  },
                );
              }
            }
          },
          onDoubleTap: () {
            if (!_controller.starttest.value) {
              _controller.starttest.value = true;
              _startTest();
            }
          },
          onTapUp: (details) {
            _controller.isListening.value = false;
            speechToText.stop();
          },
          child: Obx(
            () => CircleAvatar(
              backgroundColor: _controller.maxAttemptsReached.value
                  ? Colors.grey
                  : _controller.isListening.value
                      ? Colors.grey
                      : Colors.blue,
              radius: 40,
              child: Icon(
                !_controller.starttest.value
                    ? Icons.double_arrow_rounded
                    : _controller.isListening.value
                        ? Icons.mic
                        : Icons.mic_none,
                color: Colors.white,
                size: 40,
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
            color: Colors.blue,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 16),
            child: Text(
              'Tes Serial 7',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
            child: Text(
              'Hitung mundur dari 100 dengan mengurangi 7. Lakukan total 5 pengurangan. Ucapkan angka setelah setiap pengurangan.',
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 16, right: 16),
            child: Text(
              'Contoh: 50 - 5 = 45 (Anda hanya perlu mengucapkan Jawabannya ke mikrofon).',
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.blue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () => Text(
                    'Sisa Percobaan: ${maxAttempts.value - attempts.value}',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () => Text(
                    '${_controller.remainingSeconds.value}',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              reverse: true,
              physics: BouncingScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                margin: const EdgeInsets.only(bottom: 150),
                child: Obx(
                  () => Text(
                    _controller.starttest.value
                        ? _controller.text.value
                        : "Ketuk dua kali tombol untuk memulai tes",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: _controller.isListening.value
                          ? Colors.blue
                          : Colors.black54,
                    ),
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
