import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:synaptaid/app/modules/medical_history/controllers/medical_history_controller.dart';

import '../../../../views/covidexperience_sceen.dart';

class MedicalHistoryView extends GetView<MedicalHistoryController> {
  const MedicalHistoryView({Key? key}) : super(key: key);
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Data Riwayat Kesehatan',
          style: TextStyle(
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
                const SizedBox(height: 16),
                const Text(
                  'Apa saja makanan yang biasa dikonsumsi anak Anda? (pilih beberapa)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Biji-bijian: roti, sereal, nasi, pasta',
                          groupValue: controller.diet1,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.diet1 != value) {
                              controller.diet1 = value;
                            } else {
                              controller.diet1 = null;
                            }
                          },
                        ),
                        const Text(
                          'Biji-bijian: roti, sereal, nasi, pasta',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    // Lanjutkan dengan opsi makanan lainnya...
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.black12),
                const SizedBox(height: 16),
                const Text(
                  'Bagaimana tingkat aktivitas fisik anak Anda?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Jarang atau tidak pernah',
                          groupValue: controller.physicalActivity,
                          onChanged: (value) {
                            controller.physicalActivity = value!;
                          },
                        ),
                        const Text(
                          'Jarang atau tidak pernah',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    // Lanjutkan dengan opsi aktivitas fisik lainnya...
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.black12),
                const SizedBox(height: 16),
                const Text(
                  'Apakah anak Anda memiliki kondisi medis atau penyakit kronis? (pilih beberapa)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Gangguan perhatian dan hiperaktivitas (ADHD)',
                          groupValue: controller.medicalCondition1,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition1 != value) {
                              controller.medicalCondition1 = value;
                            } else {
                              controller.medicalCondition1 = null;
                            }
                          },
                        ),
                        const Text(
                          'Gangguan perhatian dan hiperaktivitas (ADHD)',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    // Lanjutkan dengan opsi kondisi medis lainnya...
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.black12),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Logika untuk menyimpan data dan navigasi
                        },
                        child: controller.isloading == true
                            ? const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Memuat",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 5),
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
                            : const Text(
                                'Selanjutnya',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}