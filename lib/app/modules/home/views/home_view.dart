import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/constans.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      extendBody: true,
      backgroundColor: lightGreyColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: controller.selectedIndex.value == 2
            ? primaryColor
            : Color.fromARGB(255, 56, 107, 208),
        onPressed: () {
          controller.selectedIndex.value = 2;
          controller.pages[2] = Container(); // here must be the widget as page
        },
        child: Icon(Icons.call),
        elevation: 2.0,
      ),
      body: Obx(
        () => controller.pages.elementAt(controller.selectedIndex.value),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 55,
          //  color: Colors.white,
          child: SizedBox(
            height: 70,
            child: CupertinoTabBar(
              activeColor: darkBlueColor,
              currentIndex: controller.selectedIndex.value,
              backgroundColor: Colors.white,
              iconSize: 40,
              onTap: controller.onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        controller.selectedIndex.value = 0;
                        controller.pages[0] =
                            Container(); // here must be the widget as page (Home)
                      },
                      child: Icon(Icons.home),
                      //color: Color(0xFF3A5A98),
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        controller.selectedIndex.value = 1;
                        controller.pages[1] =
                            Container(); // here must be the widget as page (Home)
                      },
                      child: Icon(Icons.call),
                      //color: Color(0xFF3A5A98),
                    ),
                  ),
                  label: 'Konsultasi',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        controller.selectedIndex.value = 2;
                        controller.pages[1] =
                            Container(); // here must be the widget as page (Home)
                      },
                    ),
                  ),
                  label: 'Tanya AI',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        controller.selectedIndex.value = 3;
                        controller.pages[3] = Container();
                      },
                      child: Icon(Icons.call),
                    ),
                  ),
                  label: 'Artikel',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        controller.selectedIndex.value = 4;
                        controller.pages[4] = Container();
                      },
                      child: Icon(Icons.call),
                    ),
                  ),
                  label: 'Pengaturan',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 /*
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    void _showAlert() {
      debugPrint("HomeController is ready: ${Get.arguments[0]['user']}");
      debugPrint("User: ${controller.auth.currentUser}");

      Get.defaultDialog(
        title: 'About CogQuest',
        titleStyle: const TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        content: const SingleChildScrollView(
          child: Center(
            child: Text(
              "CogQuest is a not-for-profit initiative by the students of Fazaia Medical College dedicated to promoting research, education, and public engagement in neurocognitive science in Pakistan. Our self-assessment tool uses two high-quality, scientifically valid cognitive tests, the Cognitive Failures Questionnaire (DE Broadbent and colleagues) and the Montreal Cognitive Assessment (ZS Nasreddine and colleagues), to provide personalized feedback and recommendations that will help you learn more about your brain, and make lifestyle choices to improve your cognitive health. Your participation, in turn, helps us understand more about the cognitive functions of the brain–mental processes that allow us to receive, store, transform, develop and recover information–and how they change with age, lifestyle and disease. is free and accessible to individuals, researchers, educators, and health care professionals. Equipped with a user-friendly interface and features like on-screen instructions, time tracking, automatic scoring, easy result storage and sharing, CogQuest can be used to assess attention, memory, language, problem solving, and reasoning without the need of a trained administrator. All you need is a quiet space, some undistracted time, and a computer, tablet or smartphone. Contact usIf you have any queries, concerns, or feedback, drop the research group leader a line at noorulainansar9@gmail.com ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () => Get.back(),
      );
   
    }
  */

/*
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'CogQuest',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 1.0, 0.0),
              child: IconButton(
                onPressed: () {
                  _showAlert();
                },
                icon: const Icon(Icons.info_outlined),
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          if (await controller.checkIfSocioDemoGraphExists() !=
                              true) {
                            Get.offAll(() => const SocioDemographicScreen());
                          } else {
                            Get.snackbar(
                              'Attention!',
                              'The Form is already Filled!',
                              titleText: const Text(
                                'Attention!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.green.shade500,
                              colorText: Colors.white,
                              snackStyle: SnackStyle.FLOATING,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Attention!',
                            'Some Error Occured!',
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
                      child: Container(
                        height: height * .22,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.9),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                                bottom: 16,
                              ),
                              child: SizedBox(
                                height: height * .2,
                                width: width * .2,
                                child: Image.asset(
                                  'assets/images/personal.png',
                                  height: height * .2,
                                  width: width * .2,
                                  fit: BoxFit
                                      .contain, // Make sure the image fits within the available space
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * .05,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  'SOCIO-DEMOGRAPHIC DATA',
                                  style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          if (await controller.checkIfSocioDemoGraphExists() !=
                              true) {
                            Get.snackbar(
                              "Attention",
                              "Fill Socio DemoGraphic Data First!",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red.shade500,
                              colorText: Colors.white,
                              snackStyle: SnackStyle.FLOATING,
                            );
                          } else if (await controller
                                  .checkIfMedicalHistoryExists() !=
                              true) {
                            Get.offAll(() => const MedicalHistoryScreen());
                          } else if (await controller
                                  .checkIfCovidExperienceExists() !=
                              true) {
                            Get.offAll(() => const CovidExperienceScreen());
                          } else if (await controller
                                  .checkIfInitialIllnessExists() !=
                              true) {
                            Get.offAll(
                                () => const SymptomsInitialIllnessScreen());
                          } else {
                            Get.snackbar(
                              'Attention!',
                              'The Form is already Filled!',
                              titleText: const Text(
                                'Attention!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.green.shade500,
                              colorText: Colors.white,
                              snackStyle: SnackStyle.FLOATING,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Attention!',
                            'Some Error Occured!',
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
                      child: Container(
                        height: height * .22,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orangeAccent.withOpacity(0.9),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          // color: Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                                bottom: 16,
                              ),
                              child: SizedBox(
                                height: height * .2,
                                width: width * .2,
                                child: Image.asset(
                                  'assets/images/health.png',
                                  height: height * .2,
                                  width: width * .2,
                                  fit: BoxFit
                                      .contain, // Make sure the image fits within the available space
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * .05,
                            ),
                            const Expanded(
                              // Use Expanded widget here to fill the remaining width
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  'MEDICAL HISTORY AND HEALTH-RELATED BEHAVIOURS ',
                                  style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          if (await controller.checkIfInitialIllnessExists() !=
                              true) {
                            Get.snackbar(
                              "Attention",
                              "Fill Medical History Data First!",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red.shade500,
                              colorText: Colors.white,
                              snackStyle: SnackStyle.FLOATING,
                            );
                          } else if (await controller
                                  .checkIfCognitiveExists() !=
                              true) {
                            Get.offAll(() => const CognitiveFailure());
                          } else {
                            Get.snackbar(
                              'Attention!',
                              'The Form is already Filled!',
                              titleText: const Text(
                                'Attention!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.green.shade500,
                              colorText: Colors.white,
                              snackStyle: SnackStyle.FLOATING,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Attention!',
                            'Some Error Occured!',
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
                      child: Container(
                        height: height * .22,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepOrange.withOpacity(0.9),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          // color: Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                                bottom: 16,
                              ),
                              child: SizedBox(
                                height: height * .2,
                                width: width * .2,
                                child: Image.asset(
                                  'assets/images/qicon.png',
                                  height: height * .2,
                                  width: width * .2,
                                  fit: BoxFit
                                      .contain, // Make sure the image fits within the available space
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * .05,
                            ),
                            const Expanded(
                              // Use Expanded widget here to fill the remaining width
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  'COGNITIVE FAILURES QUESTIONNAIRE',
                                  style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          if (await controller.checkIfCognitiveExists() !=
                              true) {
                            Get.snackbar(
                              "Attention",
                              "Fill The Forms First!",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red.shade500,
                              colorText: Colors.white,
                              snackStyle: SnackStyle.FLOATING,
                            );
                          } else {
                            Get.to(() => const MainTestScreen());
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Attention!',
                            'Some Error Occured!',
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
                      child: Container(
                        height: height * .22,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.9),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          // color: Colors.black26,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                                bottom: 16,
                              ),
                              child: SizedBox(
                                height: height * .2,
                                width: width * .2,
                                child: Image.asset(
                                  'assets/images/bacteria.png',
                                  height: height * .2,
                                  width: width * .2,
                                  fit: BoxFit
                                      .contain, // Make sure the image fits within the available space
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * .05,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  'MONTREAL COGNITIVE ASSESSMENT (MoCA)',
                                  style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
 */
  
