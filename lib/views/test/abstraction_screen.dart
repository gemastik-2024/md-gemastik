import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/controllers/abstraction_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class AbstractionScreen extends StatefulWidget {
  const AbstractionScreen({super.key});

  @override
  _AbstractionScreenState createState() => _AbstractionScreenState();
}

class _AbstractionScreenState extends State<AbstractionScreen> {
  List<bool> taskResults = List<bool>.filled(3, false);
  final controller = Get.put(AbstractionController());
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
        title: const Text(
          'Tugas Abstraksi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apa kesamaan dari setiap pasangan kata berikut? Misalnya, apa kesamaan "pisang" dan "jeruk"? Keduanya adalah buah.',
                  style: GoogleFonts.nunito(
                    fontSize: 18.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: ListView(
                    children: [
                      TaskItem(
                        statement: 'Pisang-Jeruk',
                        options: const ['Buah', 'Warna', 'Kendaraan', 'Hewan'],
                        result: 'Buah',
                        onChanged: (result) {
                          setState(() {
                            taskResults[0] = result;
                          });
                        },
                      ),
                      TaskItem(
                        statement: 'Kereta Sepeda',
                        options: const ['Buah', 'Warna', 'Kendaraan', 'Hewan'],
                        result: 'Kendaraan',
                        onChanged: (result) {
                          setState(() {
                            taskResults[1] = result;
                          });
                        },
                      ),
                      TaskItem(
                        statement: 'Jam-Penggaris',
                        options: const [
                          'Buah',
                          'Warna',
                          'Alat Ukur',
                          'Hewan'
                        ],
                        result: 'Alat Ukur',
                        onChanged: (result) {
                          setState(() {
                            taskResults[2] = result;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () async {
                        controller.submitTaskResults(taskResults);
                        sf.setInt('nextGame', 13);
                      },
                      child: Text(
                        'Kirim',
                        style: GoogleFonts.nunito(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final String statement;
  final List<String> options;
  final String result;
  final ValueChanged<bool> onChanged;

  const TaskItem({
    super.key,
    required this.statement,
    required this.options,
    required this.result,
    required this.onChanged,
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.statement,
          style: GoogleFonts.nunito(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              hint: const Text('Pilih opsi'),
              underline: const SizedBox(),
              isExpanded: true,
              value: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  widget.onChanged(value == widget.result);
                });
              },
              items: widget.options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: GoogleFonts.nunito(
                      fontSize: 16.0,
                      color: Colors.blue,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        const Divider(),
      ],
    );
  }
}
