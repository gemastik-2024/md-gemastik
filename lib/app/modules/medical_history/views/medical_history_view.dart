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
          'Medical History Data',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
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
                  'What does your diet typically consist of? (you may choose multiple options)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Grains: bread, cereal, rice, pasta',
                          groupValue: controller.diet1,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.diet1 != value) {
                              controller.diet1 =
                                  value; // Deselect if already selected
                            } else {
                              controller.diet1 = null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Grains: bread, cereal, rice, pasta',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Dairy: milk, yoghurt, cheese',
                          groupValue: controller.diet2,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.diet2 != value) {
                              controller.diet2 =
                                  value; // Deselect if already selected
                            } else {
                              controller.diet2 = null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Dairy: milk, yoghurt, cheese',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Vegetables and fruits',
                          groupValue: controller.diet3,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.diet3 != value) {
                              controller.diet3 =
                                  value; // Deselect if already selected
                            } else {
                              controller.diet3 = null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Vegetables and fruits',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Fats, oils and sugars',
                          groupValue: controller.diet4,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.diet4 != value) {
                              controller.diet4 =
                                  value; // Deselect if already selected
                            } else {
                              controller.diet4 = null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Fats, oils and sugars',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value:
                              'Protein: red meat, poultry, fish, eggs, beans',
                          groupValue: controller.diet5,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.diet5 != value) {
                              controller.diet5 =
                                  value; // Deselect if already selected
                            } else {
                              controller.diet5 = null; // Select if not selected
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Red meat, poultry, fish,eggs, \nbeans',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                /////////////2
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                const Text(
                  'How would you rate your physical activity level on the following scale?  ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Rarely to never',
                          groupValue: controller.physicalActivity,
                          onChanged: (value) {
                            controller.physicalActivity = value!;
                          },
                        ),
                        const Text(
                          'Rarely to never',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Occasional, light to moderate activity',
                          groupValue: controller.physicalActivity,
                          onChanged: (value) {
                            controller.physicalActivity = value!;
                          },
                        ),
                        const Text(
                          'Occasional, light to moderate \nactivity',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Regular, light to moderate activity',
                          groupValue: controller.physicalActivity,
                          onChanged: (value) {
                            controller.physicalActivity = value!;
                          },
                        ),
                        const Text(
                          'Regular, light to moderate activity',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Regular, vigorous activity',
                          groupValue: controller.physicalActivity,
                          onChanged: (value) {
                            controller.physicalActivity = value!;
                          },
                        ),
                        const Text(
                          'Regular, vigorous activity',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                /////////////Q3
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Do you smoke?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Yes',
                          groupValue: controller.smoke,
                          onChanged: (value) {
                            controller.smoke = value!;
                          },
                        ),
                        const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'No',
                          groupValue: controller.smoke,
                          onChanged: (value) {
                            controller.smoke = value!;
                          },
                        ),
                        const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                /////////////Alcohol
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Do you consume alcohol?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'Yes',
                          groupValue: controller.alcohol,
                          onChanged: (value) {
                            controller.alcohol = value!;
                          },
                        ),
                        const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'No',
                          groupValue: controller.alcohol,
                          onChanged: (value) {
                            controller.alcohol = value!;
                          },
                        ),
                        const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                /////////////Q4
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                const Text(
                  '.Do you have any medical condition/ chronic illness? (you may choose multiple options)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'High blood pressure',
                          groupValue: controller.medicalCondition1,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition1 != value) {
                              controller.medicalCondition1 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition1 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'High blood pressure',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Asthma',
                          groupValue: controller.medicalCondition2,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition2 != value) {
                              controller.medicalCondition2 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition2 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Asthma',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Heart disease',
                          groupValue: controller.medicalCondition3,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition3 != value) {
                              controller.medicalCondition3 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition3 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Heart disease',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Mental health disorder',
                          groupValue: controller.medicalCondition4,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition4 != value) {
                              controller.medicalCondition4 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition4 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Mental health disorder',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Diabetes',
                          groupValue: controller.medicalCondition5,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition5 != value) {
                              controller.medicalCondition5 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition5 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Diabetes',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Obesity',
                          groupValue: controller.medicalCondition6,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition6 != value) {
                              controller.medicalCondition6 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition6 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Obesity',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Kidney disease',
                          groupValue: controller.medicalCondition7,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition7 != value) {
                              controller.medicalCondition7 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition7 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Kidney disease',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'None',
                          groupValue: controller.medicalCondition8,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition8 != value) {
                              controller.medicalCondition8 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition8 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'None',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Other',
                          groupValue: controller.medicalCondition9,
                          toggleable: true,
                          onChanged: (value) {
                            if (controller.medicalCondition9 != value) {
                              controller.medicalCondition9 =
                                  value; // Deselect if already selected
                            } else {
                              controller.medicalCondition9 =
                                  null; // Select if not selected
                            }
                          },
                        ),
                        const Text(
                          'Other',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.deepPurple,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          controller.isloading.value = true;
                          if ((controller.diet5 != '' ||
                                  controller.diet4 != '' ||
                                  controller.diet3 != '' ||
                                  controller.diet1 != '' ||
                                  controller.diet2 != '') &&
                              controller.physicalActivity != '' &&
                              controller.smoke != '' &&
                              controller.alcohol != '' &&
                              (controller.medicalCondition1 != '' ||
                                  controller.medicalCondition2 != '' ||
                                  controller.medicalCondition3 != '' ||
                                  controller.medicalCondition4 != '' ||
                                  controller.medicalCondition5 != '' ||
                                  controller.medicalCondition6 != '' ||
                                  controller.medicalCondition7 != '' ||
                                  controller.medicalCondition8 != '' ||
                                  controller.medicalCondition9 != '')) {
                            controller
                                .submitForm(
                              diet1: controller.diet1,
                              diet2: controller.diet2,
                              diet3: controller.diet3,
                              diet4: controller.diet4,
                              diet5: controller.diet5,
                              physicalActivity: controller.physicalActivity,
                              smoke: controller.smoke,
                              alcohol: controller.alcohol,
                              medicalCondition1: controller.medicalCondition1,
                              medicalCondition2: controller.medicalCondition2,
                              medicalCondition3: controller.medicalCondition3,
                              medicalCondition4: controller.medicalCondition4,
                              medicalCondition5: controller.medicalCondition5,
                              medicalCondition6: controller.medicalCondition6,
                              medicalCondition7: controller.medicalCondition7,
                              medicalCondition8: controller.medicalCondition8,
                              medicalCondition9: controller.medicalCondition9,
                            )
                                .then((value) {
                              if (value == true) {
                                controller.isloading.value = false;
                                Get.offAll(
                                  () => const CovidExperienceScreen(),
                                );
                                debugPrint("Save Item");
                              }
                            });
                          } else {
                            controller.isloading.value = false;
                            Get.snackbar(
                              'Missing Fields!',
                              'Please complete the form!',
                              titleText: const Text(
                                'Attention!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red.shade500,
                              colorText: Colors.white,
                              snackStyle: SnackStyle.FLOATING,
                            );
                          }
                        },
                        child: controller.isloading == true
                            ? const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Loading",
                                    style: TextStyle(
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
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                      backgroundColor: Colors.blue,
                                      strokeWidth: 4,
                                    ),
                                  )
                                ],
                              )
                            : const Text(
                                'Next ',
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
