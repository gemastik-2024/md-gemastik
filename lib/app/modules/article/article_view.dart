import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kursus',
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CourseCard(
              imageUrl: 'assets/course_image1.png',
              title: 'Belajar Flutter untuk Pemula',
              duration: '2 jam 30 menit',
            ),
            CourseCard(
              imageUrl: 'assets/course_image2.png',
              title: 'Mastering Dart Programming',
              duration: '3 jam 15 menit',
            ),
            CourseCard(
              imageUrl: 'assets/course_image3.png',
              title: 'Membangun Aplikasi Mobile dengan Flutter',
              duration: '4 jam',
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;

  const CourseCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.timer, color: Colors.orange),
                    const SizedBox(width: 5),
                    Text(
                      duration,
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CourseScreen(),
  ));
}
