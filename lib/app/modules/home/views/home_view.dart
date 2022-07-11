import 'package:file_encryptor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  AppBar appBar = AppBar();
  @override
  Widget build(BuildContext context) {
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
              controller.pickFile();
            },
            label: Text("Encrypt New File"),
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
                  child: Text(
                    "Recent Files",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        for (var i = 0; i < controller.fileName.length; i++)
                          _data(),
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
                    "Recent Files",
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
                        Text("No Data Encrypted Yet!, Please add it first!"),
                      ],
                    ),
                  ),
                ),
              ],
            );
    });
  }

  Widget _data() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.teal,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(MdiIcons.fileCode),
                SizedBox(
                  width: 10,
                ),
                Text("data"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
