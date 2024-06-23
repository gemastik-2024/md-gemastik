import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/app/routes/app_pages.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 16.0, vertical: Get.height * 0.07),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Masuk',
                style: GoogleFonts.nunito(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Image(
                image: const AssetImage('assets/illustrations/onboarding1.png'),
                height: Get.height * 0.3,
                width: Get.width * 0.6,
                fit: BoxFit.cover,
              ),
              Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.02),
                      TextFormField(
                        controller:
                            TextEditingController(text: 'synaptaid@gmail.com',),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          labelText: 'Masukan Email',
                          labelStyle: GoogleFonts.nunito(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          controller.email = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Email';
                          } else if (!value.contains('@')) {
                            return 'Please Enter Valid Email';
                          } else if (value.contains(' ')) {
                            return 'Please Enter Valid Email';
                          } else if (value.contains('..')) {
                            return 'Please Enter Valid Email';
                          } else if (value.contains('examples')) {
                            return 'Please Enter Valid Email';
                          } else if (value.contains('example')) {
                            return 'Please Enter Valid Email';
                          } else if (value.contains('@test')) {
                            return 'Please Enter Valid Email';
                          } else if (value.contains('@testing')) {
                            return 'Please Enter Valid Email';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Obx(() => TextFormField(
                            controller: TextEditingController(text: '123456'),
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.fingerprint_outlined,
                                color: Colors.blue,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  controller.isPasswordVisible.value =
                                      !controller.isPasswordVisible.value;
                                },
                              ),
                              labelText: 'Masukan Kata Sandi',
                              labelStyle: GoogleFonts.nunito(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              controller.password = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                controller.isloading.value = false;

                                return 'Please enter password';
                              } else if (value.length < 6) {
                                controller.isloading.value = false;

                                return 'Password must be at least 6 characters!';
                              } else if (value.contains(' ')) {
                                controller.isloading.value = false;

                                return 'Password must not contain space!';
                              }
                              return null;
                            },
                          )),
                      SizedBox(height: Get.height * 0.02),
                      SizedBox(height: Get.height * 0.02),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              controller.isloading.value = true;

                              if (controller.formKey.currentState!.validate()) {
                                controller
                                    .logIn(
                                  password: controller.password.trim(),
                                  email: controller.email.trim(),
                                )
                                    .then((value) {
                                  if (value == true) {
                                    controller.isloading.value = false;

                                    Get.offAllNamed(Routes.HOME);
                                  } else {
                                    controller.isloading.value = false;
                                  }
                                });
                              }
                            } catch (e) {
                              controller.isloading.value = false;
                              Get.snackbar(
                                'Error',
                                'Some Error Occured!',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                          child: controller.isloading.value == true
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Loading",
                                      style: GoogleFonts.sora(
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
                                  'Masuk',
                                  style: GoogleFonts.sora(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum punya akun?",
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                color: Colors.black,
                              ), 
                          ),
                          TextButton(
                            onPressed: () => Get.offAllNamed(Routes.SIGN_UP),
                            child: Text(
                              "Daftar",
                              style: GoogleFonts.sora(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
