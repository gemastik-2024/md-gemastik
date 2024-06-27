import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synaptaid/app/modules/dashboard/views/dashboard_view.dart';
import 'package:synaptaid/controllers/result_controller.dart';
import 'package:synaptaid/views/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int? totalScore = 0;
  int? totalCfq = 0;
  String? userName;
  String? userEmail;
  String? userGender;

  final ResultController _controller = Get.put(ResultController());
  @override
  void initState() {
    super.initState();
    _controller.fetchUserScore().then((score) {
      setState(() {
        totalScore = score;
      });
    });
    _controller.fetchUserName().then((name) {
      setState(() {
        userName = name;
      });
    });
    _controller.fetchUserEmail().then((email) {
      setState(() {
        userEmail = email;
      });
    });
    _controller.fetchUserGender().then((gender) {
      setState(() {
        userGender = gender;
      });
    });
    _controller.fetchUserCfq().then((cfq) {
      setState(() {
        totalCfq = cfq;
      });
    });
  }

  String getRecommendations(int totalScore) {
    if (totalScore >= 26 && totalScore <= 30) {
      return "- Berolahraga secara teratur\n- Terlibat dalam aktivitas yang merangsang otak\n- Tetap berpegang pada jadwal tidur yang sehat\n- Makan makanan gaya Mediterania";
    } else if (totalScore >= 18 && totalScore <= 25) {
      return "- Konsultasikan dengan dokter\n- Berolahraga secara teratur\n- Terlibat dalam aktivitas yang merangsang otak\n- Tetap berpegang pada jadwal tidur yang sehat\n- Makan makanan gaya Mediterania";
    } else if (totalScore >= 10 && totalScore <= 17) {
      return "- Konsultasikan dengan dokter sesegera mungkin\n- Berolahraga secara teratur\n- Terlibat dalam aktivitas yang merangsang otak\n- Tetap berpegang pada jadwal tidur yang sehat\n- Makan makanan gaya Mediterania";
    } else if (totalScore >= 0 && totalScore <= 9) {
      return "- Konsultasikan dengan dokter secepat mungkin";
    } else {
      return "ERROR! Coba Lagi";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    String message;
    String src = 'assets/illustrations/Signup.png';
    if (totalScore! <= 30 && totalScore! >= 26) {
      message = 'Normal';
      src = "assets/illustrations/normalperson.png";
    } else if (totalScore! <= 25 && totalScore! >= 18) {
      message = 'Mild Cognitive Impairment';
      src = "assets/illustrations/mildsick.png";
    } else if (totalScore! <= 17 && totalScore! >= 10) {
      message = ' Moderate Cognitive Impairment';
      src = "assets/illustrations/moderatesick.png";
    } else if (totalScore! <= 9 && totalScore! >= 0) {
      message = ' Moderate Cognitive Impairment';
      src = "assets/illustrations/moderatesick.png";
    } else {
      message = 'ERROR! Coba Lagi';
      src = "assets/illustrations/error.jpg";
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        tooltip: "Beranda",
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: () {
          _controller.setZero();
          Get.offAll(() => const DashboardView());
        },
        icon: const Icon(Icons.home, color: Colors.white),
        label: const Text("Beranda"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Hasil',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Nama: ", style: GoogleFonts.nunito(fontSize: 20)),
                    Flexible(
                      child: Text(
                        userName ?? "Memuat...",
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Email: ", style: GoogleFonts.nunito(fontSize: 20)),
                    Flexible(
                      child: Text(
                        userEmail ?? "Memuat...",
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Jenis Kelamin: ",
                        style: GoogleFonts.nunito(fontSize: 20)),
                    Flexible(
                      child: Text(
                        userGender ?? "Memuat...",
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: Container(
                  width: width * 0.9,
                  height: height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                "Skor MOCA: ",
                                style: GoogleFonts.nunito(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "$totalScore / 30",
                                  style: GoogleFonts.nunito(
                                    fontSize: 22,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              Text(
                                "Skor CFQ: ",
                                style: GoogleFonts.nunito(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                totalCfq.toString(),
                                style: GoogleFonts.nunito(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.5,
                                    child: Text(
                                      message,
                                      style: GoogleFonts.nunito(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image(
                                    image: AssetImage(src),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "Rekomendasi:",
                            style: GoogleFonts.nunito(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                                                    SizedBox(
                            width: width * 0.8,
                            child: Text(
                              getRecommendations(totalScore ?? 0),
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Get.offAll(() => const HomeScreen());
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.blue,
                          //       padding:
                          //           const EdgeInsets.fromLTRB(50, 10, 50, 10),
                          //       textStyle: const TextStyle(
                          //           fontSize: 20, fontWeight: FontWeight.bold)),
                          //   child: const Text(
                          //     "Beranda",
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 17,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

