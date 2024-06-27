
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/views/test/memory_test_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/list.dart';
import '../controllers/animal_name_controller.dart';

class AnimalNameGuessScreen extends StatefulWidget {
  const AnimalNameGuessScreen({super.key});
  @override
  _AnimalNameGuessScreenState createState() => _AnimalNameGuessScreenState();
}

class _AnimalNameGuessScreenState extends State<AnimalNameGuessScreen> {
  final AnimalNameTestController _controller =
      Get.put(AnimalNameTestController());
  int currentPictureIndex = 0;
  int score = 0;
  TextEditingController guessController = TextEditingController();
  bool _isloading = false;

  late SharedPreferences sf;
  @override
  initState() {
    super.initState();
    initalizeSharedPref();
  }

  Future<void> initalizeSharedPref() async {
    sf = await SharedPreferences.getInstance();
  }

  void checkAnswer(String guess) {
    String answer = animalsNameList[currentPictureIndex];
    if (guess.toLowerCase().trim() == answer.toLowerCase()) {
      setState(() {
        score++;
        print(score);
        guessController.clear();
        if (currentPictureIndex < animalsPicList.length - 1) {
          currentPictureIndex++;
        } else {
          // Game Over
          _showGameOverDialog();
        }
      });
    } else {
      setState(() {
        guessController.clear();
        if (currentPictureIndex < animalsPicList.length - 1) {
          currentPictureIndex++;
        } else {
          // Game Over
          _showGameOverDialog();
        }
      });
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terima Kasih Telah Bermain'),
          content: const Text('Lanjut ke Game Berikutnya'),
          actions: <Widget>[
            TextButton(
              child: const Text('Lanjut'),
              onPressed: () {
                {
                  if (_controller.score != -1) {
                    _controller
                        .submitForm(
                      score: score,
                    )
                        .then((value) async {
                      if (value == true) {
                        await sf.setInt('animalGameScore', score);
                        //int scoredata = sf.getInt('animalGameScore') ?? 0;
                        // debugPrint('scoredata:');
                        // debugPrint(scoredata.toString());
                        setState(() {
                          currentPictureIndex = 0;
                          score = 0;
                        });
                        await sf.setInt('nextGame', 5);
                        Get.offAll(() => const MemoryTestScreen());
                      }
                    });
                  } else {
                    Get.snackbar(
                      'Kesalahan',
                      'Lengkapi Formulir!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Tebak Gambar',
          style: GoogleFonts.nunito(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 280,
                height: 270,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      animalsPicList[currentPictureIndex],
                    ),
                    fit: BoxFit.contain,
                  ),
                  border: Border.all(
                    width: 2,
                    color: Colors.purple,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: guessController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Masukkan tebakan Anda',
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      )),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    _isloading = true;
                  });
                  try {
                    if (guessController.text.isNotEmpty) {
                      String guess = guessController.text;
                      checkAnswer(guess);
                      setState(() {
                        _isloading = false;
                      });
                    } else {
                      setState(() {
                        _isloading = false;
                      });
                      Get.snackbar(
                        'Kesalahan',
                        'Harap Masukkan Nama Hewan',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  } catch (e) {
                    setState(() {
                      _isloading = false;
                    });
                    Get.snackbar(
                      'Kesalahan',
                      'Terjadi Kesalahan!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: _isloading == true
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Memuat",
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              backgroundColor: Colors.blue,
                              strokeWidth: 4,
                            ),
                          )
                        ],
                      )
                    : Text(
                        'Kirim',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}