import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synaptaid/app/routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/campaign_banner.dart';
import 'widgets/category_list.dart';
import 'widgets/features_appbar.dart';
import 'widgets/menu.dart';
import 'widgets/expanding_appbar.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
/*
    return PopScope(
      canPop: controller.showExitPopup(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              ExpandingAppBar(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hi ${controller.name}, bagaimana harimu",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Flexible(child: ExploreCourseList())
                ],
              )
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                CategoriesList(),
                Menu(),
                SizedBox(height: 5),
                FeaturesAppBar(),
                SizedBox(height: 20),
                CampaignBanner(),
              ],
            ),
          ),
        ),
      ),
    );

*/

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            ExpandingAppBar(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    controller.removeUser();
                    Get.offAllNamed(Routes.SIGN_IN);
                  },
                  child: Text("Logout"),
                ),
                Text(
                  "Hi ${controller.name}, bagaimana harimu",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Flexible(
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount: controller.exploreCourses.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 20.0 : 0),
                          child: GestureDetector(
                            onTap: () {
                              debugPrint(controller.userId);
                              var x = GetStorage().read('phone');
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 330.0,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    gradient: controller
                                        .exploreCourses[index].background,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 32),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                        .exploreCourses[index]
                                                        .courseSubtitle,
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16.0,
                                                      color: const Color(
                                                          0xFF797F8A),
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    controller
                                                        .exploreCourses[index]
                                                        .courseTitle,
                                                    style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0),
                                                      fontSize: 22.0,
                                                      decoration:
                                                          TextDecoration.none,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                  "assets/illustrations/${controller.exploreCourses[index].illustration}",
                                                  fit: BoxFit.cover,
                                                  height: 100,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            )
          ];
        },
        body: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              CategoriesList(),
              Menu(),
              SizedBox(height: 5),
              FeaturesAppBar(),
              SizedBox(height: 20),
              CampaignBanner(),
            ],
          ),
        ),
      ),
    );
  }
}
