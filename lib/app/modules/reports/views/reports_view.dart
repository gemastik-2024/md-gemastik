import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import '../../../../constants/constans.dart';
import '../controllers/reports_controller.dart';
import 'widgets/condition.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
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
                    color: Theme.of(context).colorScheme.onPrimary,
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
                                const Text(
                                  'Total\nPetugas',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  controller.totalPetugas.toString(),
                                  style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                    Text(
                                      "${controller.dateFromText.value} - ${controller.dateToText.value}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
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
                                      overflow: TextOverflow.ellipsis,
                                      'Monitor\nKandang (${controller.monitoringKandang['total']})',
                                      style: const TextStyle(
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
                                        'Monitor\nTernak (${controller.monitoringTernak['total']})',
                                        style: const TextStyle(
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
                                        'Treatment (${controller.treatment['total']})',
                                        style: const TextStyle(
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
                                            const DataLabelSettings(
                                                textStyle: TextStyle(
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
                            const Text(
                              'Kondisi Peternakan',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
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
                                    style: const TextStyle(color: Colors.grey),
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
                                    title: 'Hewan Ternak',
                                    value: controller.totalTernak.toString(),
                                    endValue: 'Ekor',
                                    imagePath: 'assets/icons/hewan_ternak.png',
                                    color: const Color(0XFF9552EA));
                              } else if (index == 1) {
                                return ConditionItem(
                                    title: 'Total Kandang',
                                    value: controller.totalKandang.toString(),
                                    endValue: 'Kandang',
                                    imagePath: 'assets/icons/kandang.png',
                                    color: const Color(0XFF3C9D4E));
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
