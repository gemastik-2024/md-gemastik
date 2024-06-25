import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:synaptaid/app/modules/socio_demographic/controllers/socio_demographic_controller.dart';

class SocioDemographicView extends GetView<SocioDemographicController> {
  const SocioDemographicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Socio-Demographic Data',
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
                SizedBox(
                  height: Get.height * 0.01,
                ),
                /////Name
                TextFormField(
                  decoration: const InputDecoration(
                    // hintText: 'Enter Your Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    ),
                    labelText: 'Enter Your Name',
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
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),

                Obx(() => Row(
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            controller.gender.value = value.toString();
                          },
                        ),
                        const Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: 'Female',
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            controller.gender.value = value.toString();
                          },
                        ),
                        const Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: 'Others',
                          groupValue: controller.gender.value,
                          onChanged: (value) {
                            controller.gender.value = value.toString();
                          },
                        ),
                        const Text(
                          'Others',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
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
                const Text(
                  'Age',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.deepPurple,
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
                        disabledHint: const Text(
                          'Select your age',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                        ),
                        value: controller.age.value,
                        onChanged: (value) {
                          controller.age.value = value.toString();
                        },
                        items: const [
                          DropdownMenuItem(
                            value: '18-25 years',
                            child: Text('18-25 years'),
                          ),
                          DropdownMenuItem(
                            value: '26-35 years',
                            child: Text('26-35 years'),
                          ),
                          DropdownMenuItem(
                            value: '36-45 years',
                            child: Text('36-45 years'),
                          ),
                          DropdownMenuItem(
                            value: '46-55 years',
                            child: Text('46-55 years'),
                          ),
                          DropdownMenuItem(
                            value: '55-65 years',
                            child: Text('55-65 years'),
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
                const Text(
                  'Residence',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      Flexible(
                        child: Radio(
                          value: 'Rural',
                          groupValue: controller.residence.value,
                          onChanged: (value) {
                            controller.residence.value = value.toString();
                          },
                        ),
                      ),
                      const Flexible(
                        child: Text(
                          'Rural',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Radio(
                          value: 'Semi-urban',
                          groupValue: controller.residence.value,
                          onChanged: (value) {
                            controller.residence.value = value.toString();
                          },
                        ),
                      ),
                      const Flexible(
                        child: Text(
                          'Semi-urban',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Radio(
                          value: 'Urban',
                          groupValue: controller.residence.value,
                          onChanged: (value) {
                            controller.residence.value = value.toString();
                          },
                        ),
                      ),
                      const Flexible(
                        child: Text(
                          'Urban',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
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
                const Text(
                  'Education',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.deepPurple,
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
                        disabledHint: const Text(
                          'Select your Education',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                        ),
                        value: controller.education.value,
                        onChanged: (value) {
                          controller.education.value = value!;
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'Matriculation (grade 9 and 10)',
                            child: Text('Matriculation (grade 9 and 10)'),
                          ),
                          DropdownMenuItem(
                            value: 'Intermediate (grade 11 and 12)',
                            child: Text('Intermediate (grade 11 and 12)'),
                          ),
                          DropdownMenuItem(
                            value: 'Undergraduate degree (bachelor’s)',
                            child: Text('Undergraduate degree (bachelor’s)'),
                          ),
                          DropdownMenuItem(
                            value: 'Postgraduate degree',
                            child: Text('Postgraduate degree'),
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
                const Text(
                  'Profession',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    // hintText: 'Enter Your Name',
                    prefixIcon: Icon(
                      Icons.work,
                      color: Colors.deepPurple,
                    ),
                    labelText: 'Enter Your profession',
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
                      return 'Please enter your profession';
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
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: () async {
                            try {
                              if (controller.formKey.currentState!.validate()) {
                                if (controller.gender == '' ||
                                    controller.residence == '') {
                                  Get.snackbar(
                                    'Error',
                                    'Complete the form! ',
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
                                'Error',
                                'Some Error Occured! ',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
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
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                        backgroundColor: Colors.blue,
                                        strokeWidth: 4,
                                      ),
                                    )
                                  ],
                                )
                              : const Text(
                                  'Next ',
                                  style: TextStyle(
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
