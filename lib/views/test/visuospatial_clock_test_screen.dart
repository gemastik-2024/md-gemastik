
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/controllers/clock_test_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../animal_name_screen.dart';

class ClockTestScreen extends StatefulWidget {
  const ClockTestScreen({super.key});
  @override
  State<ClockTestScreen> createState() => _ClockTestScreenState();
}

class _ClockTestScreenState extends State<ClockTestScreen> {
  final ClockTestController _controller = Get.put(ClockTestController());
  late SharedPreferences sf;
  @override
  initState() {
    super.initState();
    initalizeSharedPref();
  }

  Future<void> initalizeSharedPref() async {
    sf = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Silakan Pilih Waktu "10 lewat 11"'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _controller.selectedTime != null
                  ? 'Waktu Terpilih: ${_controller.selectedTime!.hour}:${_controller.selectedTime!.minute}'
                  : 'Silakan pilih waktu 10 lewat 11',
              style: GoogleFonts.nunito(fontSize: 20),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _showTimePickerDialog(context);
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue[400],
                ),
                child:  Center(
                  child: Text(
                    'Pilih Waktu',
                    style: GoogleFonts.nunito(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => _controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    )
                  : DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue,
                      ),
                      child: SizedBox(
                        width: 200,
                        height: 46,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () async {
                            if (_controller.selectedTime != null) {
                              _controller.increaseScore();

                              if (_controller.selectedTime!.hour == 23 ||
                                  _controller.selectedTime!.hour == 11) {
                                _controller.increaseScore();
                              }

                              if (_controller.selectedTime!.minute == 10) {
                                _controller.increaseScore();
                              }
                            }
                            await sf.setInt('nextGame', 4);
                            await _controller.saveScoreToFirestore();
                            Get.offAll(() => const AnimalNameGuessScreen());
                          },
                          child: Text(
                            'Kirim',
                            style: GoogleFonts.nunito(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showTimePickerDialog(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selected != null) {
      _controller.setTime(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selected.hour,
        selected.minute,
      ));
    }
  }
}