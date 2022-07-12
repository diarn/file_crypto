import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_cryptor/file_cryptor.dart';

import '../../home/views/my_widget.dart';

class DescryptController extends GetxController {
  RxList<io.FileSystemEntity> file = <io.FileSystemEntity>[].obs;
  RxList<String> fileName = <String>[].obs;
  TextEditingController key = TextEditingController();
  TextEditingController inFileNameDescrypt = TextEditingController();
  TextEditingController outFileNameDescrypt = TextEditingController();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getFiles() async {
    final directory = (await getExternalStorageDirectory())!.path;
    // setState(() {
    file.value = io.Directory("$directory/data/")
        .listSync(); //use your folder name insted of resume.
    // });
    // inspect(file);
    for (var i = 0; i < file.length; i++) {
      var x = file[i].path.split("/");
      fileName.add(x[9]);
      fileName.refresh();
      // inspect(fileName);
    }
  }

  openDescryptDialog(Size size, String filePath, String fileName) async {
    inFileNameDescrypt.text = fileName;
    Get.dialog(Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        height: size.height * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyFormField(
              inputController: inFileNameDescrypt,
              label: "Original File Name",
              textInputType: TextInputType.text,
              hintText: "hintText",
              readOnly: true,
            ),
            MyFormField(
              inputController: key,
              label: "Your Security Key",
              textInputType: TextInputType.text,
              hintText: "Input the key for this file",
              readOnly: false,
            ),
            MyFormField(
              inputController: outFileNameDescrypt,
              label: "Output Name",
              textInputType: TextInputType.text,
              hintText: "Feel free to take anything you want",
              readOnly: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: Colors.teal[300],
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text("Cancel"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Material(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Get.back();
                      isLoading.value = true;
                      isLoading.refresh();
                      descryptFile(filePath).then((_) {
                        isLoading.value = false;
                        isLoading.refresh();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Descrypt",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  descryptFile(String filePath) async {
    final directory = (await getExternalStorageDirectory())!.path;
    inspect(directory);
    final Directory _appDocDirFolder = Directory('$directory/output/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
    } else {
      //if folder not exists create folder and then return its path
      await _appDocDirFolder.create(recursive: true);
    }

    FileCryptor fileCryptor = FileCryptor(
      key: key.text,
      iv: 16,
      dir: "$directory/output",
    );
    try {
      File decryptedFile = await fileCryptor.decrypt(
          inputFile: filePath, outputFile: outFileNameDescrypt.text);

      inspect(decryptedFile.absolute);

      Get.showSnackbar(GetSnackBar(
        title: "Success",
        message: "The file has been encrypted",
        duration: 1500.milliseconds,
        backgroundColor: Colors.teal[400]!,
      ));
    } catch (e) {
      inspect(e);
      Get.showSnackbar(GetSnackBar(
        title: "Failed",
        message:
            "Invalid or corrupted pad block, please make sure to enter the right key for the file",
        duration: 1500.milliseconds,
        backgroundColor: Colors.red,
      ));
    }
  }
}
