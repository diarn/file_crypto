import 'dart:developer';

import 'package:file_encryptor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final AppBar appBar = AppBar();
  @override
  Widget build(BuildContext context) {
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
          body: _content(context, size),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              controller.pickFile(size);
            },
            label: Text("Enkripsi File Baru"),
            icon: Icon(MdiIcons.lockPlus),
            backgroundColor: Colors.teal,
          )),
    );
  }

  Widget _content(BuildContext context, Size size) {
    return Obx(() {
      return controller.file.length > 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: appBar.preferredSize.height,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "File Sebelumnya",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.DESCRYPT);
                        },
                        child: Text(
                          "lihat semua file yang dienkripsi",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  height: appBar.preferredSize.height,
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
                        Text(
                            "Belum ada data yang dienkripsi!, silahkan melakukan enkripsi file terlebih dahulu!"),
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
            controller.openDescryptDialog(size, filePath, fileName);
            inspect(filePath);
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
