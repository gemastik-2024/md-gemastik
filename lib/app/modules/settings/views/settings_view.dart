
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/app/modules/settings/controllers/settings_controller.dart';
import 'package:synaptaid/app/routes/app_pages.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key, this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan Profil',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/profile_picture.png'), // Ganti dengan path gambar Anda
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Nama Pengguna',
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'nama.pengguna@example.com',
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.person, color: Colors.blue),
                title: Text(
                  'Edit Profil',
                  style: GoogleFonts.nunito(),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                onTap: () {
                  // Tambahkan aksi ketika item ini ditekan
                },
              ),
              Divider(color: Colors.blue),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.blue),
                title: Text(
                  'Ubah Kata Sandi',
                  style: GoogleFonts.nunito(),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                onTap: () {
                  // Tambahkan aksi ketika item ini ditekan
                },
              ),
              Divider(color: Colors.blue),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.blue),
                title: Text(
                  'Notifikasi',
                  style: GoogleFonts.nunito(),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                onTap: () {
                  // Tambahkan aksi ketika item ini ditekan
                },
              ),
              Divider(color: Colors.blue),
              ListTile(
                leading: Icon(Icons.language, color: Colors.blue),
                title: Text(
                  'Bahasa',
                  style: GoogleFonts.nunito(),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                onTap: () {
                  // Tambahkan aksi ketika item ini ditekan
                },
              ),
              Divider(color: Colors.blue),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text(
                  'Keluar',
                  style: GoogleFonts.nunito(),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();

                Get.offAllNamed(Routes.SIGN_IN);
              },
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
    home: SettingsView(),
  ));
}
