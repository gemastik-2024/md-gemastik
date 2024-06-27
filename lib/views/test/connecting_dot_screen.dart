import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/connecting_dots_controller.dart';
import 'cube_drawing_test_screen.dart';

class ConnectingDotsScreen extends StatefulWidget {
  const ConnectingDotsScreen({super.key});

  @override
  _DotScreenState createState() => _DotScreenState();
}

class _DotScreenState extends State<ConnectingDotsScreen> {
  final ConnectingDotsController _controller =
      Get.put(ConnectingDotsController());
  List<int> selectedIndices = [];
  late SharedPreferences sf;
  @override
  void initState() {
    super.initState();
    initalizeSharedPref();
    Future.delayed(const Duration(seconds: 2), () {
      _countdownTimer();
    });
  }

  Future<void> initalizeSharedPref() async {
    sf = await SharedPreferences.getInstance();
  }

  bool nextscreen = false;
  final List<dynamic> patternSequence = [
    1,
    'A',
    2,
    'B',
    3,
    'C',
    4,
    'D',
    5,
    'E'
  ];

  var isPatternCorrect = [];
  bool randomizeDots = true;
  int score = 0;

  List<Offset> dotPositions = [
    Offset(120.0, 350.0),
    Offset(140.0, 160.0),
    Offset(270.0, 280.0),
    Offset(220.0, 350.0),
    Offset(170.0, 60.0),
    Offset(270.0, 160.0),
    Offset(70.0, 40.0),
    Offset(200.0, 250.0),
    Offset(70.0, 260.0),
    Offset(270.0, 60.0),
  ];

  List<dynamic> selectedValues = [];
  bool isTimerStarted = false;

  void selectDot(int index) {
    setState(() {
      if (selectedIndices.isNotEmpty && selectedIndices.last == index) {
        // Batalkan pemilihan titik terakhir jika sudah dipilih
        selectedIndices.removeLast();
        selectedValues.removeLast();
      } else {
        // Pilih titik
        if (selectedValues.contains(patternSequence[index])) {
        } else {
          selectedIndices.add(index);
          selectedValues
              .add(patternSequence[index]); // Simpan nilai titik yang dipilih
        }
      }
      if (selectedValues.length == patternSequence.length) {
        _validatePattern();
        nextText();
      }
    });
  }

  void _validatePattern() {
    for (int i = 0; i < patternSequence.length; i++) {
      if (selectedValues[i] == patternSequence[i]) {
        score++;
      } else {
        return;
      }
    }
    return;
  }

  void _countdownTimer() async {
    while (_controller.remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      _controller.decrementSeconds();
    }
    isTimerStarted = false;

    if (nextscreen == false) {
      nextText();
    }
  }

  Future<void> nextText() async {
    nextscreen = true;

    if (score == 10) {
      await _controller.updatetestScore(1);
    } else {
      await _controller.updatetestScore(0);
    }
    Future.delayed(const Duration(seconds: 3));
    {
      sf.setInt('nextGame', 2);
      Get.offAll(() => const DrawingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes Visualisasi',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hubungkan Titik-Titik',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Pilih Titik-Titik, dari angka ke huruf secara berurutan. Pertama pilih angka lalu pilih huruf. Mulai dari 1 lalu ke A lalu ke 2 dan seterusnya.',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              const Divider(
                thickness: 1,
                color: Colors.blue,
                indent: 16,
                endIndent: 16,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Obx(
                () => Text(
                  "Waktu Tersisa: ${_controller.remainingSeconds} detik",
                  style:GoogleFonts.nunito(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.65,
                color: Colors.grey[300],
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final containerSize =
                        Size(constraints.maxWidth, constraints.maxHeight);

                    return Stack(
                      children: [
                        for (var i = 0; i < patternSequence.length; i++)
                          if (i <
                              dotPositions
                                  .length) // Periksa apakah indeks valid
                            Positioned(
                              left: dotPositions[i].dx - 25,
                              top: dotPositions[i].dy - 25,
                              child: GestureDetector(
                                onTap: () {
                                  selectDot(i);
                                },
                                child: Dot(
                                  index: patternSequence[i],
                                  isSelected: selectedIndices.contains(i),
                                ),
                              ),
                            ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final dynamic index;
  final bool isSelected;

  const Dot({super.key, required this.index, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          index.toString(),
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
