import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/constants/constans.dart';

class MenuItemOneView extends StatelessWidget {
  const MenuItemOneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), 'Segera Hadir'),
        backgroundColor: darkBlueColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/illustrations/coming_soon.png', // Ganti dengan path gambar Anda
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Segera Hadir',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kami sedang mempersiapkan sesuatu yang menakjubkan untuk Anda. Nantikan ya!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 30),
              Icon(
                Icons.hourglass_empty,
                size: 100,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MenuItemOneView(),
  ));
}

