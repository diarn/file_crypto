import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/how_to_use_controller.dart';

class HowToUseView extends GetView<HowToUseController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double top = MediaQuery.of(context).padding.top;
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.teal[50]!,
                Colors.teal[200]!,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: top,
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.chevron_left_rounded,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Kembali',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Petunjuk pemakaian Aplikasi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text("Enkripsi"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Merupakan fitur untuk mengamankan sebuah  file dokumen yang berekstensi Pdf, Word, Exel, Teks dan Powerpoint.",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Deskripsi",
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Merupakan fitur untuk membuka file dokumen yang telah terenkripsi. Penamaan file dokumen yang akan didekripsi harus sesuai ekstensi file dokumen  yang telah terenkripsi sebelumnya.",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Download",
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Merupakan fitur untuk mengunduh file dokumen yang telah terenkripsi",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Key",
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  "Merupakan fitur untuk menambahkan kunci, Kunci yang harus digunakan adalah angka, dan jumlah angka yang digunakan minimal 32 karakter",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
