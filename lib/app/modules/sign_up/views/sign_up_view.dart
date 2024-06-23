import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/app/modules/sign_up/controllers/sign_up_controller.dart';
import 'package:synaptaid/app/routes/app_pages.dart';

class SignUpView extends GetView<SignUpControllerz> {
  const SignUpView({Key? key}) : super(key: key);
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
                'Daftar',
                style: GoogleFonts.nunito(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Image(
                image: const AssetImage('assets/illustrations/onboarding.png'),
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
                      TextFormField(
                        decoration: InputDecoration(
                          // hintText: 'Enter Your Name',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          labelText: 'Masukan Nama',
                          labelStyle: GoogleFonts.nunito(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          controller.name = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukan Nama Anda';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Get.height * 0.02),
                      TextFormField(
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
                          } else if (!value.contains('.')) {
                            return 'Please Enter Valid Email';
                          } else if (value.contains(' ')) {
                            return 'Please Enter Valid Email';
                          } else if (value.contains('..')) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Obx(() => TextFormField(
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
                                return 'Please enter password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters!';
                              } else if (value.contains(' ')) {
                                return 'Password must not contain space!';
                              }
                              return null;
                            },
                          )),
                      SizedBox(height: Get.height * 0.02),
                      Obx(() => TextFormField(
                            obscureText: !controller.isRepasswordVisible.value,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.fingerprint_outlined,
                                color: Colors.blue,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isRepasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  controller.isRepasswordVisible.value =
                                      !controller.isRepasswordVisible.value;
                                },
                              ),
                              labelText: 'Masukan Ulang Kata Sandi',
                              labelStyle: GoogleFonts.nunito(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              controller.repassword = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                controller.isloading.value = false;

                                return 'Please enter password';
                              } else if (controller.repassword !=
                                  controller.password) {
                                controller.isloading.value = false;

                                return 'Password MisMatched';
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
                            controller.isloading.value = true;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Before you start....'),
                                content: const SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Sebagai pendaftaran ini akan mengizinkan anda untuk mengakses semua fitur aplikasi. Dengan ini anda setuju dengan semua syarat dan ketentuan yang berlaku.'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Setuju'),
                                    onPressed: () {
                                      Get.back();
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller
                                            .signup(
                                          name: controller.name.trim(),
                                          password: controller.password.trim(),
                                          email: controller.email.trim(),
                                        )
                                            .then((value) {
                                          if (value == true) {
                                            controller.isloading.value = false;
                                            Get.offAllNamed(
                                              Routes.SIGN_IN,
                                            );
                                          }
                                        });
                                      } else {
                                        controller.isloading.value = false;
                                      }
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Tidak Setuju'),
                                    onPressed: () {
                                      debugPrint("Email : ${controller.email}");
                                      debugPrint(
                                          "Password : ${controller.password}");
                                      Get.back();
                                      Get.offAllNamed(
                                        Routes.ON_BOARDING,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
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
                                  'Daftar',
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
                            "Sudah punya akun?",
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(
                                Routes.SIGN_IN,
                              );
                            },
                            child: Text(
                              "Masuk",
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
