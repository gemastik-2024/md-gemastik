import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/views/test/abstraction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:language_tool/language_tool.dart' as langTool;
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/fluency_test_controller.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({Key? key}) : super(key: key);

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  late SharedPreferences sf;
  final FluencyTestController _controller = Get.put(FluencyTestController());
  SpeechToText speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  late langTool.LanguageTool _languageTool;
  var subjectWords = <String>[];
  String currentLetter = '';
  bool isTimerStarted = false;
  String text = 'Tekan tombol dan mulai berbicara';
  var words = <String>[];
  var word;
  bool isSpeechAvailable = false;
  bool starttest = true;

  @override
  void initState() {
    super.initState();
    initalizeSharedPref();
    speechToText.initialize();
    _languageTool = langTool.LanguageTool();
  }

  Future<void> initalizeSharedPref() async {
    sf = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes Bahasa',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Text(
              'Kefasihan Verbal',
              style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 10,
            ),
            child: Text(
              '''Sebutkan sebanyak mungkin kata yang bisa Anda pikirkan yang dimulai dengan huruf tertentu dari alfabet yang akan diberitahukan kepada Anda setelah Anda mengklik pengatur waktu 60 detik. Anda bisa mengatakan kata apa saja yang Anda inginkan, kecuali kata benda khusus, angka, atau kata yang dimulai dengan suara yang sama tetapi memiliki akhiran yang berbeda, misalnya, cinta, pecinta, mencintai.''',
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.015),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Huruf: $currentLetter",
                  style: GoogleFonts.nunito(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                starttest
                    ? "Ketuk dua kali tombol untuk memulai tes"
                    : "Tekan tombol dan mulai berbicara",
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Center(
              child: Text(
                "$words",
                style: GoogleFonts.nunito(
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
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
          onLongPress: () async {
            if (!_controller.isListening.value &&
                !starttest &&
                isTimerStarted) {
              bool available = await speechToText.initialize();
              if (available) {
                _startListening();
              } else {
                debugPrint('Pengenalan ucapan tidak tersedia');
              }
            }
          },
          onDoubleTap: () {
            if (starttest) {
              setState(() {
                starttest = false;
              });
              _startTest();
            }
          },
          onLongPressUp: _stopListening,
          child: CircleAvatar(
            backgroundColor: starttest
                ? Colors.blue
                : isTimerStarted
                    ? Colors.blue
                    : Colors.grey,
            radius: 40,
            child: Icon(
              starttest
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
    );
  }

  void _startTest() {
    setState(() {
      isTimerStarted = true;
      _controller.remainingSeconds.value = _controller.timerDuration.inSeconds;
      subjectWords.clear();
      words.clear();
    });

    _countdownTimer();
    _speakRandomLetter();
  }

  void _countdownTimer() async {
    while (_controller.remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      _controller.remainingSeconds--;
    }
    isTimerStarted = false;
    _stopListening();
    _calculateScore();
  }

  Future<void> _calculateScore() async {
    var score = 0;
    if (words.length >= 11) {
      score = 1;
      await _controller.updateScore(score);
    } else {
      score = 0;
      await _controller.updateScore(score);
    }

    Future.delayed(const Duration(seconds: 2), () {
      _showDialog();
    });
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Tes Selesai',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        content: Text(
          'Anda telah berhasil menyelesaikan tes bahasa.',
          style: GoogleFonts.nunito(
            fontSize: 18,
            color: Colors.blue,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              sf.setInt('nextGame', 12);
              Get.offAll(() => const AbstractionScreen());
            },
            child: Text(
              'Selanjutnya',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _speakRandomLetter() async {
    var randomLetter = 'F'; // Untuk sementara gunakan huruf 'F'
    setState(() {
      currentLetter = randomLetter;
    });
    await flutterTts.setLanguage('id-ID'); // Ubah bahasa ke Indonesia
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak('Hurufnya adalah $randomLetter');
  }

  void _startListening() {
    speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          word = result.recognizedWords.toLowerCase();
          var spokenWords = word.split(' ');
          for (var word in spokenWords) {
            _checkAndAddWord(word.toLowerCase());
          }
        }
      },
    );
    _controller.isListening.value = true;
  }

  Future<void> _checkAndAddWord(String word) async {
    if (await _isvalidWord(word)) {
      if (words.contains(word)) {
        return;
      }
      setState(() {
        words.add(word);
      });
    }
  }

  Future<bool> _isvalidWord(String word) async {
    if (word[0].toLowerCase() == currentLetter.toLowerCase()) {
      final errors = await _languageTool.check(word);

      if (errors.isEmpty) {
        return true;
      } else {
        return errors.isNotEmpty;
      }
    } else {
      return false;
    }
  }

  void _stopListening() {
    speechToText.stop();
    _controller.isListening.value = false;
  }
}