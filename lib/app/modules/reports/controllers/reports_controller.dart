import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  final chartData = <ChartData>[
    ChartData('Mon. Kandang', 35, const Color(0XFFEC6B56)),
    ChartData('Mon. Ternak', 35, const Color(0XFFFFC154)),
    ChartData('Treatment', 35, const Color(0XFF47B39C)),
  ].obs;

  DateTime? dateFrom;
  DateTime? dateTo;
  final dateFromText = '2024-02-29'.obs;
  final dateToText = '2024-02-29'.obs;
  DateTimeRange? dateTimeRange;
  final totalPetugas = '30'.obs;
  final monitoringKandang = <String, dynamic>{}.obs;
  final monitoringTernak = <String, dynamic>{}.obs;
  final treatment = <String, dynamic>{}.obs;

  final kondisiSort = SortType.avg.obs;

  final totalTernak = '0'.obs;
  final totalKandang = '0'.obs;
  final kondisiLantai = <String, dynamic>{}.obs;
  final kondisiPakan = <String, dynamic>{}.obs;
  final kondisiCuaca = <String, dynamic>{}.obs;
  final kondisiKesehatan = <String, dynamic>{}.obs;

  Future<void> initDashboard([DateTimeRange? dateRange]) async {
    final data = dummyData['data'] as Map<String, dynamic>;
    dateFrom = DateTime.parse(data['dari']!['tanggal']);
    dateFromText.value = data['dari']['waktu'];
    dateTo = DateTime.parse(data['sampai']['tanggal']);
    dateToText.value = data['sampai']['waktu'];
    totalPetugas.value = data['total_petugas'].toString();

    monitoringKandang.value = data['monitoring_kandang'];
    monitoringTernak.value = data['monitoring_ternak'];
    treatment.value = data['treatment'];

    chartData.value = [
      ChartData('Mon. Kandang', int.parse(monitoringKandang['persen']),
          const Color(0XFFEC6B56)),
      ChartData('Mon. Ternak', int.parse(monitoringTernak['persen']),
          const Color(0XFFFFC154)),
      ChartData(
          'Treatment', int.parse(treatment['persen']), const Color(0XFF47B39C)),
    ];

    totalKandang.value = data['total_kandang'].toString();
    totalTernak.value = data['total_ternak'].toString();
    kondisiLantai.value = data['kondisi_lantai'];
    kondisiPakan.value = data['kondisi_pakan'];
    kondisiCuaca.value = data['kondisi_cuaca'];
    kondisiKesehatan.value = data['kondisi_kesehatan'];

    // isDone.value = true;
  }

  void pickDateRange([DateTimeRange? initialDateRange]) async {
    final dateRange = initialDateRange ??
        DateTimeRange(
          start: dateFrom!,
          end: dateTo!,
        );
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: Get.context!,
      initialDateRange: dateRange,
      firstDate: DateTime(2019),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    dateTimeRange = newDateRange;
    await initDashboard(newDateRange);
  }

  void changeSort() {
    if (kondisiSort.value == SortType.avg) {
      kondisiSort.value = SortType.max;
    } else if (kondisiSort.value == SortType.max) {
      kondisiSort.value = SortType.min;
    } else {
      kondisiSort.value = SortType.avg;
    }
  }

  @override
  void onInit() {
    super.onInit();
    initDashboard();
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color? color;
}

abstract class SortType {
  SortType._();
  static const String avg = 'avg';
  static const String max = 'max';
  static const String min = 'min';
}

const dummyData = {
  "success": true,
  "message": "berhasil mendapatkan data",
  "data": {
    "dari": {"tanggal": "2024-03-04", "waktu": "4 Mar"},
    "sampai": {"tanggal": "2024-04-03", "waktu": "Hari ini"},
    "total_petugas": 11,
    "monitoring_kandang": {"total": 79, "persen": "46.2"},
    "monitoring_ternak": {"total": 44, "persen": "25.7"},
    "treatment": {"total": 48, "persen": "28.1"},
    "total_ternak": 325,
    "total_kandang": 14,
    "kondisi_lantai": {
      "max": {"id": 3, "teks": "kotor", "persen": "50"},
      "min": {"id": 1, "teks": "basah", "persen": "16.7"},
      "avg": {"id": 2, "teks": "kering", "persen": "33.3"}
    },
    "kondisi_pakan": {
      "max": {"id": 7, "teks": "dominan batang", "persen": "50"},
      "min": {"id": 1, "teks": "layak", "persen": "7.1"},
      "avg": {"id": 6, "teks": "pakan habis", "persen": "42.9"}
    },
    "kondisi_cuaca": {
      "max": {"id": 7, "teks": "normal", "persen": "53.8"},
      "min": {"id": 1, "teks": "panas", "persen": "7.7"},
      "avg": {"id": 5, "teks": "cerah", "persen": "38.5"}
    }
  }
};
