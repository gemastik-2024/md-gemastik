import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/app/modules/on_boarding/controllers/on_boarding_controller.dart';
import 'package:synaptaid/app/modules/on_boarding/views/widgets/animated_container.dart';
import 'package:synaptaid/constants/constans.dart';

import '../../../routes/app_pages.dart';
import 'widgets/on_boarding_content.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              controller.user != null
                  ? Get.offAllNamed(Routes.HOME)
                  : Get.offAllNamed(Routes.SIGN_IN);
            },
            child: Text(
              'Lanjut',
              style: GoogleFonts.sora(
                color: darkBlueColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (value) {
                      controller.currentPage.value = value;
                    },
                    itemCount: controller.onboardData.length,
                    itemBuilder: (context, index) => OnBoardingContent(
                      image: controller.onboardData[index]['image'] ?? '',
                      text: controller.onboardData[index]['text'] ?? '',
                      heading: controller.onboardData[index]['heading'] ?? '',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Column(
                      children: <Widget>[
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            controller.onboardData.length,
                            (index) => AnimatedContainerWidget(index: index),
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  if (controller.currentPage.value ==
                      controller.onboardData.length - 1) {
                    controller.user != null
                        ? Get.offAllNamed(Routes.HOME)
                        : Get.offAllNamed(Routes.SIGN_IN);
                  } else {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: darkBlueColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
