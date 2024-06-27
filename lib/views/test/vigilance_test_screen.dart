
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/vigilancetest_controller.dart';
import 'serial7_test_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class VigilanceScreen extends StatefulWidget {
  const VigilanceScreen({Key? key}) : super(key: key);

  @override
  VigilanceScreenState createState() => VigilanceScreenState();
}

class VigilanceScreenState extends State<VigilanceScreen> {
  late SharedPreferences sf;
  FlutterTts flutterTts = FlutterTts();
  final VigilanceController _controller = Get.put(VigilanceController());
  int correct = 0;
  int score = 0;
  int errors = 0;
  var sequence = [
    'F',
    'B',
    'A',
    'C',
    'M',
    'N',
    'A',
    'A',
    'J',
    'K',
    'L',
    'B',
    'A',
    'F',
    'A',
    'K',
    'D',
    'E',
    'A',
    'A',
    'J',
    'A',
    'M',
    'O',
    'F',
    'A',
    'A',
    'B'
  ];
  bool isClicked = false;
  bool canrespond = false;
  int currentIndex = 0;
  Timer? timer;

  void _startTest() {
    _startSpeaking();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPref();
  }

  void initializeSharedPref() async {
    sf = await SharedPreferences.getInstance();
  }

  void _startSpeaking() {
    timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      if (currentIndex < sequence.length) {
        var currentLetter = sequence[currentIndex];
        flutterTts.speak(currentLetter);
        currentIndex++;
        canrespond = true;
        if (currentLetter == 'A') {
          Future.delayed(const Duration(milliseconds: 2900), () {
            if (!isClicked) {
              errors++;
            }
          });
        }
        if (currentIndex >= sequence.length) {
          timer?.cancel();
          sf.setInt('nextGame', 9);
          await _calculateScore();
          Future.delayed(const Duration(seconds: 4), () {
            Get.offAll(() => const Serial7Screen());
          });
        }
      }
    });
  }

  Future<void> _calculateScore() async {
    if (errors <= 3) {
      score = 1;
    } else {
      score = 0;
    }
    _controller.saveScore(score);
  }

  void _compareResponse(String response) {
    if (currentIndex > 0 && currentIndex <= sequence.length) {
      var spokenLetter = sequence[currentIndex - 1];
      if (spokenLetter == 'A' && response == 'A' && canrespond) {
        correct++;
      } else if (spokenLetter != 'A' && response == 'A' && canrespond) {
        errors++;
      } else {}
      canrespond = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tes Perhatian',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 16.0),
            child: Text(
              'Tes Vigilance',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 16.0, right: 5.0),
            child: Text(
              'Akan dibacakan serangkaian huruf kepada Anda. Setiap kali huruf A diucapkan, ketuk tangan Anda sekali. Jangan mengetuk tangan Anda pada huruf lainnya.',
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          Divider(
            color: Colors.blue,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          SizedBox(height: height * 0.15),
          Center(
            child: Obx(
              () => Text(
                _controller.startTest.value
                    ? "Ketuk tombol saat huruf 'A' diucapkan"
                    : "Ketuk dua kali tombol untuk memulai tes",
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.5,
                height: height * 0.08,
                child: GestureDetector(
                  onDoubleTap: () {
                    if (!_controller.startTest.value) {
                      _controller.startTest.value = true;
                      _startTest();
                    }
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () {
                      if (_controller.startTest.value) {
                        isClicked = true;
                        _compareResponse('A');
                        Future.delayed(const Duration(seconds: 3), () {
                          isClicked = false;
                        });
                      }
                    },
                    child: Obx(
                      () => Text(
                        _controller.startTest.value ? 'Ketuk' : 'Mulai',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
