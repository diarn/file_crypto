import 'package:file_encryptor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/beranda_controller.dart';

class BerandaView extends GetView<BerandaController> {
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
          height: (size.height),
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
                height: 16,
              ),
              SizedBox(
                height: top,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    SizedBox(
                      height: size.width * 0.1,
                      child: Image.asset("assets/images/encrypt icon.png"),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "File Encryptor",
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  'Enkripsi File\nUntuk Keamanan\nData Anda',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: SizedBox(),
              ),
              buttons(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttons() {
    return Column(
      children: [
        button(
          "Enkripsi File",
          () {
            Get.toNamed(Routes.HOME);
          },
        ),
        SizedBox(
          height: 16,
        ),
        button(
          "Deskripsi File",
          () {
            Get.toNamed(Routes.DESCRYPT);
          },
        ),
        SizedBox(
          height: 16,
        ),
        button(
          "Cara Penggunaan",
          () {
            Get.toNamed(Routes.HOW_TO_USE);
          },
        ),
        SizedBox(
          height: 16,
        ),
        button(
          "Tentang Aplikasi",
          () {
            Get.toNamed(Routes.ABOUT_APP);
          },
        ),
      ],
    );
  }

  Padding button(String label, Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                label,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
