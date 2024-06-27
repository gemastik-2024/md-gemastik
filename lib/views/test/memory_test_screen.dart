
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/views/test/forward_test_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../controllers/memorytest_controller.dart';

class MemoryTestScreen extends StatefulWidget {
  const MemoryTestScreen({Key? key}) : super(key: key);

  @override
  MemoryTestScreenState createState() => MemoryTestScreenState();
}

class MemoryTestScreenState extends State<MemoryTestScreen> {
  late SharedPreferences sf;

  @override
  initState() {
    super.initState();
    initalizeSharedPref();
    initializeSpeechToText();
  }

  Future<void> initalizeSharedPref() async {
    sf = await SharedPreferences.getInstance();
  }

  SpeechToText speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  List<String> wordList = [
    'wajah',
    'beludru',
    'gereja',
    'aisyah',
    'merah',
  ];

  List<String> recognizedWordsList = [];
  bool isSpeaking = true;
  bool alert = false;
  bool isTimerStarted = false;

  final MemoryTestController _controller = Get.put(MemoryTestController());

  void _startTest() {
    isTimerStarted = true;
    _controller.timeDuration();
    _countdownTimer();
    _controller.disableMicButton();
    speakWordList();
  }

  void _countdownTimer() async {
    while (_controller.remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      _controller.decrementSeconds();
    }
    isTimerStarted = false;
    _stopListening();
    if (alert == false) {
      alertdialog();
    }
  }

  void _stopListening() {
    speechToText.stop();
    _controller.isListening.value = false;
  }

  void resetScreen() {
    _controller.remainingSeconds.value = 60;
    _controller.isListening.value = false;
    _controller.recognizedText.value = '';
    _controller.spokenSentence.value = 'Tahan tombol dan mulai berbicara';
    _controller.disableMicButton();
  }

  Future<void> initializeSpeechToText() async {
    bool isAvailable = await speechToText.initialize();
    if (!isAvailable) {
      debugPrint('Pengenalan suara tidak tersedia');
    }
  }

  void speakWordList() async {
    for (String word in wordList) {
      await flutterTts.speak(word);
      await Future.delayed(const Duration(milliseconds: 1500));
    }
    _controller.enableMicButton();
  }

  void alertdialog() {
    alert = true;
    _controller.remainingSeconds.value = 1;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tes Memori Selesai'),
          content: const Text(
              'Anda akan diminta untuk mengingat kata-kata tersebut lagi di akhir tes.'),
          actions: [
            TextButton(
              onPressed: () {
                sf.setInt('nextGame', 6);
                Navigator.of(context).pop();
                Get.offAll(() => const ForwardDigitSpan());
              },
              child: const Text('Lanjut'),
            ),
          ],
        );
      },
    );
  }

  Future<String> getRecognizedWords() async {
    return _controller.recognizedText.value;
  }

  var i = 0;
  @override
  Widget build(BuildContext context) {
    debugPrint('Metode build dipanggil sebanyak ${++i} kali');
    final double height = MediaQuery.sizeOf(context).height;

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
                _controller.isMicEnabled.value &&
                !_controller.starttest.value &&
                isTimerStarted) {
              bool available = await speechToText.initialize();
              if (available) {
                _controller.isListening.value = true;
                _controller.recognizedText.value = '';
                speechToText.listen(
                  onResult: (result) {
                    if (result.finalResult) {
                      _controller.spokenSentence.value =
                          result.recognizedWords.trim().toLowerCase();
                      List<String> spokenWords =
                          _controller.spokenSentence.value.split(' ');
                      for (String spokenWord in spokenWords) {
                        if (!recognizedWordsList.contains(spokenWord) &&
                            wordList.contains(spokenWord)) {
                          recognizedWordsList.add(spokenWord);
                          _controller.incrementWordCount();
                        }
                      }
                      if (_controller.currentTrial.value == 2) {
                        Future.delayed(const Duration(seconds: 3), () {
                          alertdialog();
                        });
                      }
                      if (_controller.currentTrial.value < 2) {
                        _controller.recognizedText.value = '';
                        Future.delayed(const Duration(seconds: 3), () {
                          _controller.incrementTrial();
                          resetScreen();
                          speakWordList();
                        });
                      }
                    } else {
                      _controller.recognizedText.value = result.recognizedWords;
                    }
                  },
                );
              } else {
                debugPrint('Pengenalan suara tidak tersedia');
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
            _controller.isListening.value = false;
            speechToText.stop();
          },
          child: Obx(
            () => CircleAvatar(
              backgroundColor: _controller.starttest.value
                  ? Colors.blue
                  : _controller.isMicEnabled.value
                      ? Colors.blue
                      : Colors.grey,
              radius: 40,
              child: Icon(
                _controller.starttest.value
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
        title: Text('Tes Memori',
            style: GoogleFonts.nunito(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => Text(
                "Uji Coba ${_controller.currentTrial.value} dari 2",
                style:
                    GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              "Ini adalah tes memori. Daftar kata-kata akan dibacakan kepada Anda yang harus Anda ulangi dan ingat.",
              style: GoogleFonts.nunito(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: height * 0.01),
            const Divider(
              color: Colors.blue,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(height: height * 0.01),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      'Kata yang Cocok: ${_controller.wordCount.value}',
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => Text(
                      '${_controller.remainingSeconds}',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.1),
            Obx(
              () => Text(
                _controller.starttest.value
                    ? "Ketuk dua kali tombol untuk memulai tes"
                    : _controller.isListening.value
                        ? _controller.recognizedText.value
                        : _controller.spokenSentence.value,
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: _controller.isListening.value
                      ? Colors.blue
                      : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
