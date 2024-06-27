
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import '../../../../constants/constans.dart';
import '../controllers/reports_controller.dart';
import 'widgets/condition.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({Key? key}) : super(key: key);
  
  // Function to get current timestamp with exception for March 4th
  String getCurrentTimestamp() {
    DateTime now = DateTime.now();
    if (now.month == 3 && now.day == 4) {
      // Handle March 4th exception
      return "Not March 4th";
    } else {
      // Return current timestamp in desired format
      return "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: Text(
          'Reports',
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    color: darkBlueColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  height: Get.size.height / 1.16,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total\nAnak',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.nunito(
                                      fontSize: 20, color: Colors.grey),
                                ),
                                Obx(() => Text(
                                  controller.totalTernak.value.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                            InkWell(
                              onTap: () => controller.pickDateRange(),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0XFF003F5C),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Obx(() => Text(
                                      "${controller.dateFromText.value} - ${controller.dateToText.value}",
                                      style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 35, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 37,
                                      width: 11,
                                      decoration: BoxDecoration(
                                        color: const Color(0XFFEC6B56),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Aktivitas\nKognitif (${controller.monitoringKandang['total']})',
                                      style: GoogleFonts.nunito(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      height: 37,
                                      width: 11,
                                      decoration: BoxDecoration(
                                        color: const Color(0XFFFFC154),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        'Aktivitas\nMotorik (${controller.monitoringTernak['total']})',
                                        style: GoogleFonts.nunito(
                                            color: Colors.grey, fontSize: 15)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      height: 37,
                                      width: 11,
                                      decoration: BoxDecoration(
                                        color: const Color(0XFF47B39C),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        'Terapi (${controller.treatment['total']})',
                                        style: GoogleFonts.nunito(
                                            color: Colors.grey, fontSize: 15)),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                width: 220,
                                height: 220,
                                child: SfCircularChart(
                                    margin: EdgeInsets.zero,
                                    series: <CircularSeries>[
                                      PieSeries<ChartData, String>(
                                        dataSource: controller.chartData,
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        dataLabelMapper: (ChartData data, _) =>
                                            '${data.y}%',
                                        startAngle: 90,
                                        endAngle: 90,
                                        dataLabelSettings:
                                            DataLabelSettings(
                                                textStyle: GoogleFonts.nunito(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                isVisible: true),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Perkembangan Anak',
                              style: GoogleFonts.nunito(
                                  color: Colors.grey, fontSize: 20),
                            ),
                            InkWell(
                              onTap: controller.changeSort,
                              child: Row(
                                children: [
                                  Text(
                                    controller.kondisiSort.value == SortType.avg
                                        ? 'Avg'
                                        : controller.kondisiSort.value ==
                                                SortType.max
                                            ? 'Max'
                                            : 'Min',
                                    style: GoogleFonts.nunito(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Icon(controller.kondisiSort.value ==
                                          SortType.avg
                                      ? Icons.swap_vert
                                      : controller.kondisiSort.value ==
                                              SortType.max
                                          ? Icons.arrow_upward
                                          : Icons.arrow_downward),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: Get.size.height / 3.2,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 2),
                            itemCount: 8,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return ConditionItem(
                                    title: 'Skor Kognitif',
                                    value: controller.totalTernak.toString(),
                                    endValue: 'Poin',
                                    imagePath: 'assets/icons/cognitive.png',
                                    color: Colors.white);
                              } else if (index == 1) {
                                return ConditionItem(
                                    title: 'Skor Motorik',
                                    value: controller.totalKandang.toString(),
                                    endValue: 'Poin',
                                    imagePath: 'assets/icons/motorik.png',
                                    color: Colors.white);
                              } else {
                                return const SizedBox(height: 12);
                              }
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
