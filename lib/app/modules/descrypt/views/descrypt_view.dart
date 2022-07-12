import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/descrypt_controller.dart';

class DescryptView extends GetView<DescryptController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.getFiles();
    return Scaffold(
        appBar: AppBar(
          title: Text('All Encrypted Files'),
          centerTitle: true,
        ),
        body: Obx(() {
          return GridView.count(
            padding: EdgeInsets.all(10),
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            crossAxisCount: 2,
            children: [
              for (var i = 0; i < controller.fileName.length; i++)
                Material(
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      controller.openDescryptDialog(size,
                          controller.file[i].path, controller.fileName[i]);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  color: Colors.teal),
                              child: SizedBox(
                                width: size.width * 0.5,
                                height: size.width * 0.33,
                                child: Image.network(
                                    "https://static.thenounproject.com/png/1631724-200.png"),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("${controller.fileName[i]}"),
                            ),
                          ],
                        )),
                  ),
                ),
            ],
          );
        }));
  }
}
