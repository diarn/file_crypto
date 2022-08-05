import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: _content(context, size, top),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.pickFile(size);
          },
          label: Text("Enkripsi File Baru"),
          icon: Icon(MdiIcons.lockPlus),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }

  Widget _content(BuildContext context, Size size, double top) {
    return Obx(() {
      return controller.file.length > 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: top,
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                        Text("Kembali"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "File Sebelumnya",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        for (var i = 0; i < controller.fileName.length; i++)
                          _data(size, controller.fileName[i],
                              controller.file[i].path),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: top,
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                        Text("Kembali"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "File Sebelumnya",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.flaskEmptyOff,
                          size: size.width * 0.5,
                          color: Colors.teal[200],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: Text(
                            "Belum ada data yang dienkripsi!, silahkan melakukan enkripsi file terlebih dahulu!",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
    });
  }

  Widget _data(Size size, String fileName, String filePath) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.teal,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            // controller.openDescryptDialog(size, filePath, fileName);
            Get.dialog(
              SimpleDialog(
                title: Text("Pilih Aksi"),
                contentPadding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.teal[300],
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text("Download"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.teal,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            Get.back();
                            controller.openDescryptDialog(
                                size, filePath, fileName);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Deskripsi",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
            // inspect(filePath);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(MdiIcons.fileCode),
                SizedBox(
                  width: 10,
                ),
                Text(fileName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
