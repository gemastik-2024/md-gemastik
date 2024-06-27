
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/app/modules/socio_demographic/controllers/socio_demographic_controller.dart';

class SocioDemographicView extends GetView<SocioDemographicController> {
  const SocioDemographicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Biodata',
          style: GoogleFonts.nunito(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                /////Name
                TextFormField(
                  decoration: const InputDecoration(
                    // hintText: 'Enter Your Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    labelText: 'Masukkan Nama Anda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.name.value = value.toString();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nama Anda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                Text(
                  'Jenis Kelamin',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                Obx(() => Row(
                      children: [
                        Radio(
                          value: 'Laki-laki',
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            controller.gender.value = value.toString();
                          },
                        ),
                        Text(
                          'Laki-laki',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: 'Perempuan',
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            controller.gender.value = value.toString();
                          },
                        ),
                        Text(
                          'Perempuan',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: 'Lainnya',
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            controller.gender.value = value.toString();
                          },
                        ),
                        Text(
                          'Lainnya',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                Text(
                  'Usia',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(
                      () => DropdownButton<String>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(12),
                        disabledHint: Text(
                          'Pilih usia Anda',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                        value: controller.age.value,
                        onChanged: (value) {
                          controller.age.value = value.toString();
                        },
                        items: const [
                          DropdownMenuItem(
                            value: '18-25 tahun',
                            child: Text('18-25 tahun'),
                          ),
                          DropdownMenuItem(
                            value: '26-35 tahun',
                            child: Text('26-35 tahun'),
                          ),
                          DropdownMenuItem(
                            value: '36-45 tahun',
                            child: Text('36-45 tahun'),
                          ),
                          DropdownMenuItem(
                            value: '46-55 tahun',
                            child: Text('46-55 tahun'),
                          ),
                          DropdownMenuItem(
                            value: '55-65 tahun',
                            child: Text('55-65 tahun'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tempat Tinggal',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      Flexible(
                        child: Radio(
                          value: 'Pedesaan',
                          groupValue: controller.residence.value,
                          onChanged: (value) {
                            controller.residence.value = value.toString();
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Pedesaan',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Radio(
                          value: 'Semi-perkotaan',
                          groupValue: controller.residence.value,
                          onChanged: (value) {
                            controller.residence.value = value.toString();
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Semi-perkotaan',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Radio(
                          value: 'Perkotaan',
                          groupValue: controller.residence.value,
                          onChanged: (value) {
                            controller.residence.value = value.toString();
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Perkotaan',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                Text(
                  'Pendidikan',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(
                      () => DropdownButton<String>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(12),
                        disabledHint: Text(
                          'Pilih Pendidikan Anda',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                        value: controller.education.value,
                        onChanged: (value) {
                          controller.education.value = value!;
                        },
                        items: const [
                          DropdownMenuItem(
                            value: '7',
                            child: Text('7'),
                          ),
                          DropdownMenuItem(
                            value: '10',
                            child: Text('10'),
                          ),
                          DropdownMenuItem(
                            value: '(S1)',
                            child: Text('S1)'),
                          ),
                          DropdownMenuItem(
                            value: 'S2',
                            child: Text('S2'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                Text(
                  'Pekerjaan',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    // hintText: 'Enter Your Name',
                    prefixIcon: Icon(
                      Icons.work,
                      color: Colors.blue,
                    ),
                    labelText: 'Masukkan pekerjaan Anda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.profession.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan pekerjaan Anda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () async {
                            try {
                              if (controller.formKey.currentState!.validate()) {
                                if (controller.gender == '' ||
                                    controller.residence == '') {
                                  Get.snackbar(
                                    'Kesalahan',
                                    'Lengkapi formulir!',
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                } else {
                                  controller.isloading = true;
                                  controller.submitForm(
                                    name: controller.name.value,
                                    gender: controller.gender.value,
                                    age: controller.age.value,
                                    residence: controller.residence.value,
                                    education: controller.education.value,
                                    profession: controller.profession.value,
                                  );
                                }
                              }
                            } catch (e) {
                              debugPrint('LoginCalled() called Error "$e"');
                              Get.snackbar(
                                'Kesalahan',
                                'Terjadi kesalahan!',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                          child: controller.isloading == true
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
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                        backgroundColor: Colors.blue,
                                        strokeWidth: 4,
                                      ),
                                    )
                                  ],
                                )
                              : Text(
                                  'Selanjutnya',
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}