
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/controllers/orientation_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class OrientationScreen extends StatefulWidget {
  const OrientationScreen({super.key});

  @override
  State<OrientationScreen> createState() => _OrientationScreenState();
}

class _OrientationScreenState extends State<OrientationScreen> {
  final OreientationController controller = Get.put(OreientationController());
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
        title: Text(
          'Verifikasi Tanggal',
          style: GoogleFonts.nunito(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Silakan masukkan detail berikut:',
              style: GoogleFonts.nunito(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                controller.selectDate(context);
              },
              child: IgnorePointer(
                child: TextField(
                  controller: controller.dayController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal-Bulan-Tahun Saat Ini',
                    labelStyle: GoogleFonts.nunito(color: Colors.blue),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller.placeController,
              decoration: InputDecoration(
                labelText: 'Tempat',
                hintText: "Indonesia",
                labelStyle: GoogleFonts.nunito(color: Colors.blue),
                hintStyle: GoogleFonts.nunito(color: Colors.orange),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller.cityController,
              decoration: InputDecoration(
                labelText: 'Kota',
                hintText: "Palembang",
                labelStyle: GoogleFonts.nunito(color: Colors.blue),
                hintStyle: GoogleFonts.nunito(color: Colors.orange),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.blue,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () async {
                      await sf.setInt('nextGame', 1);
                      controller.verifyInputs();
                    },
                    child: Text(
                      'Kirim',
                      style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
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
}
